import 'package:flutter/material.dart';

import '../elements/DrawerWidget.dart';
import '../models/route_argument.dart';
import '../elements/SearchResultsWidget.dart';
import '../pages/donation_store.dart';
import '../pages/home.dart';
import '../pages/chat.dart';
import '../pages/users.dart';
import '../pages/assistance_request.dart';
import '../pages/chat_users.dart';
import '../repository/user_repository.dart';
import '../repository/settings_repository.dart';

class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool temp = false;

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
        if(currentTab == 3)
          temp = true;
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = DonationStoreWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = currentUser.value.userRole == '1' || currentUser.value.userRole == '2'
            ? UsersWidget(parentScaffoldKey: widget.scaffoldKey)
            : AssistanceRequestWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage = currentUser.value.userRole == '1' || currentUser.value.userRole == '2'
              ? ChatUserWidget(parentScaffoldKey: widget.scaffoldKey)
              : ChatWidget(
              parentScaffoldKey: widget.scaffoldKey,
              user:  currentUser.value
          );
          break;
        case 4:
          widget.currentPage = SearchResultWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  currentUser.value.userRole == '1' || currentUser.value.userRole == '2'
                      ? Icons.supervised_user_circle
                      : Icons.add_circle
              ),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
                title: new Container(height: 5.0),
                icon: setting.value.brightness.value == Brightness.light
                ? Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                      BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                    ],
                  ),
                  child: new Icon(Icons.home, color: Theme.of(context).primaryColor),
                )
                : Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: new Icon(Icons.home, color: Theme.of(context).primaryColor),
                ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              title: new Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search_sharp),
              title: new Container(height: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}

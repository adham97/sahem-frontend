import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/PlatformCategoriesWidget.dart';
import '../elements/NotificationButton.dart';
import '../repository/settings_repository.dart' as settingRepo;

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget>{
  HomeController _con;
  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).home,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
        actions: <Widget>[
          new NotificationButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  leading: Icon(
                    Icons.category,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    S.of(context).platform_categories,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              PlatformCategoriesWidget(platformCategoryList: _con.platformCategories),
            ],
          ),
        )
      ),
    );
  }
}
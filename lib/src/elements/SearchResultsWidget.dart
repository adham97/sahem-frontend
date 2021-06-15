import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sahem/src/elements/SearchList.dart';
import 'package:sahem/src/repository/search_repository.dart';

import '../../generated/l10n.dart';
import '../controllers/search_controller.dart';
import '../elements/NotificationButton.dart';
import '../repository/settings_repository.dart' as settingRepo;

//import '../elements/CardWidget.dart';
import '../elements/CircularLoadingWidget.dart';
//import '../elements/ProductItemWidget.dart';
import '../models/route_argument.dart';


class SearchResultWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SearchResultWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  SearchController _con;

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
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
              S.of(context).search,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
        actions: <Widget>[
          new NotificationButton(),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _con.searchText = text;
                  });
                },
                onSubmitted: (text) {
                  setState(() {
                    _con.searchText = text;
                  });
                },
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: ' ',//S.of(context).search_for_markets_or_products,
                  hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                ),
              ),
            ),
            FutureBuilder(
              future: getSearch(_con.searchText),
              builder: (context, snapshot) {
                if(snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: SizedBox(height: 0),
                    ),
                  );
                } else {
                  return snapshot.hasData
                      ? SearchList(result: snapshot.data)
                      : Center(child: new CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

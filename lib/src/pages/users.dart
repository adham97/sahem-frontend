import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/users_controller.dart';
import '../elements/NotificationButton.dart';
import '../elements/UsersListItemWidget.dart';
import '../repository/settings_repository.dart' as settingRepo;

class UsersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  UsersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _UsersWidgetState createState() => _UsersWidgetState();
}

class _UsersWidgetState extends StateMVC<UsersWidget> {

  UsersController _con;
  _UsersWidgetState() : super(UsersController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,//Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).users,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
        actions: <Widget>[
          new NotificationButton(),
        ],
      ),
      body: Container(
        child: UsersListItemWidget(usersList: _con.users),
      ),
    );
  }
}

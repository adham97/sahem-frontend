import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/driver_controllers.dart';
import '../elements/DrawerWidget.dart';
import '../elements/NotificationDriverList.dart';
import '../elements/ChatButton.dart';
import '../models/driver.dart';
import '../repository/driver_repository.dart';
import '../repository/settings_repository.dart';

class DriverWidget extends StatefulWidget {
  @override
  _DriverWidgetState createState() => _DriverWidgetState();
}

class _DriverWidgetState extends StateMVC<DriverWidget> {
  DriverController _con;
  _DriverWidgetState() : super(DriverController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _con.scaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).delivery_orders,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
        actions: <Widget>[
          new ChatButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshNotification,
        child: Container(
          child: FutureBuilder<List<Driver>>(
            future: getDriverNotifications(),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return Container(
                  child: Center(
                    child: SizedBox(height: 0)
                  ),
                );
              } else {
                return snapshot.hasData
                    ? NotificationDriverList(notificationsDriver: snapshot.data)
                    : Center(child: new CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

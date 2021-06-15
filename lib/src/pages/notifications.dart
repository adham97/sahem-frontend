import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/notification_controller.dart';
import '../elements/NotificationList.dart';
import '../repository/notification_repository.dart';
import '../repository/settings_repository.dart';

class NotificationsWidget extends StatefulWidget {
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends StateMVC<NotificationsWidget> {
  NotificationController _con;

  _NotificationsWidgetState() : super(NotificationController()) {
    _con = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).notifications,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: Container(
          child: FutureBuilder(
            future: getNotifications(),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text(
                      'Loading ...',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                );
              } else {
                return snapshot.hasData
                    ? NotificationList(notifications: snapshot.data)
                    : Center(child: new CircularProgressIndicator());
              }
            },
          )
      ),
    );
  }
}

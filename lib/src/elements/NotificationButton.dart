import 'package:flutter/material.dart';

import '../repository/notification_repository.dart';

class NotificationButton extends StatefulWidget {
  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      onPressed: () => Navigator.of(context).pushReplacementNamed('/Notifications'),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Icon(
            Icons.notifications,
            color: Theme.of(context).focusColor.withOpacity(1),
            size: 28,
          ),
          FutureBuilder(
            future: getNotificationsCount(),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return SizedBox(height: 0);
              } else {
                return snapshot.hasData
                    ? Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${snapshot.data}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(0),
                        decoration:
                        BoxDecoration(color: Color(0xffce2029), borderRadius: BorderRadius.all(Radius.circular(10))),
                        constraints: BoxConstraints(minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18),
                      )
                    : SizedBox(height: 0);
              }
            },
          ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}

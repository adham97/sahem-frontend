import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../generated/l10n.dart';
import '../pages/assistance_response.dart';
import '../pages/platform_support.dart';
import '../models/notification.dart';
import '../models/assistance.dart';
import '../models/platform.dart';
import '../repository/settings_repository.dart';
import '../repository/notification_repository.dart';

class NotificationList extends StatefulWidget {
  final List<Notifications> notifications;
  NotificationList({this.notifications, Key key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.notifications.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.notifications[index];
          return GestureDetector(
            onTap: () async{
              if(item.notificationTypeId == '1' || item.isUserNotification()) {
                await updateStatus(item.notificationsId).then((value) {
                  if(value == 'Update notification successfully') {
                    setState(() {
                      item.statusId = false;
                    });
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssistanceResponseWidget(
                    assistance: Assistance.fromJSON(item.body['assistance']),
                    user: item.user,
                    platformCategoriesId: Assistance.fromJSON(item.body['assistance']).platformCategoriesId,
                  )),
                );
              }
              if(item.notificationTypeId == '4' || item.notificationTypeId == '5') {
                await updateStatus(item.notificationsId).then((value) {
                  if(value == 'Update notification successfully') {
                    setState(() {
                      item.statusId = false;
                    });
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlatformSupportWidget(
                    platform: Platform.fromJSON(item.body['platform']),
                    user: item.user,
                  )),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: item.statusId == true ? Color(0xffe6f2ff) : Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(
                            (item.notificationTypeId == '2' || item.notificationTypeId == '3' || item.notificationTypeId == '5')
                                ? '${GlobalConfiguration().getString('api_base_url')}images/logo.png'
                                : item.user.image,
                          ),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black87,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(text: item.title),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${DateFormat.E('${setting.value.mobileLanguage.value}').format(item.date)} '
                                    '${S.of(context).at} '
                                    '${DateFormat.jm('${setting.value.mobileLanguage.value}').format(item.date)}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

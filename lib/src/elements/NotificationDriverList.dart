import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../generated/l10n.dart';
import '../models/driver.dart';
import '../pages/order.dart';
import '../repository/settings_repository.dart';
import '../repository/notification_repository.dart';

class NotificationDriverList extends StatefulWidget {
  final List<Driver> notificationsDriver;
  NotificationDriverList({this.notificationsDriver, Key key}) : super(key: key);

  @override
  _NotificationDriverListState createState() => _NotificationDriverListState();
}

class _NotificationDriverListState extends State<NotificationDriverList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.notificationsDriver.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.notificationsDriver[index];
          return GestureDetector(
            onTap: () async {
              await updateStatus(item.id).then((value) {
                if(value == 'Update notification successfully') {
                  setState(() {
                    item.statusId = false;
                  });
                }
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderWidget(driver: item)),
              );
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
                          image: NetworkImage(item.user.image),
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

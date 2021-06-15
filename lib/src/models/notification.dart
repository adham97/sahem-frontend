import 'dart:convert';

import '../models/assistance.dart';
import '../models/user.dart';

class Notifications {
  String notificationsId;
  User user;
  Map<String, dynamic> body;
  String title;
  String notificationTypeId;
  bool statusId;
  DateTime date;

  Notifications();

  Notifications.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      notificationsId = jsonMap['notifications_id'];
      user = User.fromJSON(jsonMap['user']);
      body = jsonMap['body'];
      title = jsonMap['title'];
      notificationTypeId = jsonMap['notification_type_id'];
      statusId = jsonMap['status_id'] == '1' ? true : false;
      date = DateTime.parse(jsonMap['date']);
    } catch (e) {
      print(e);
    }
  }

  bool isUserNotification() {
    return this.notificationTypeId == '2' || this.notificationTypeId == '3';
  }
}

import '../models/user.dart';

class ChatUsers {
  String userId;
  String content;
  DateTime time;
  User user;

  ChatUsers();

  ChatUsers.fromJSON(Map<String, dynamic> jsonMap){
    try {
      userId = jsonMap['from_user_id'];
      content = jsonMap['content'];
      time = DateTime.parse(jsonMap['time']);
      user = User.fromJSON(jsonMap['user']);
    } catch (e) {
      print(e);
    }
  }
}
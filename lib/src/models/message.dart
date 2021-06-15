class Message {
  String fromUserId;
  bool isFromSender;
  String content;
  String messageType;
  String time;

  Message();

  Message.fromJSON(Map<String, dynamic> jsonMap){
    try {
      fromUserId = jsonMap['from_user_id'];
      isFromSender = jsonMap['is_from_sender'] == '1' ? true : false;
      content = jsonMap['content'];
      messageType = jsonMap['message_type'];
      time = jsonMap['time'];
    } catch (e) {
      print(e);
    }
  }
}
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import '../elements/ChatBubble.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../models/question.dart';
import '../repository/user_repository.dart';

class ChatList extends StatefulWidget {
  final List<Message> messages;
  final User user;
  final Question question;

  ChatList({this.messages, this.user, this.question, Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(right: 20,left: 20),
              scrollDirection: Axis.vertical,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                    isMe: currentUser.value.userRole =='1' || currentUser.value.userRole =='2'
                        ? !widget.messages.elementAt(index).isFromSender
                        : widget.messages.elementAt(index).isFromSender,
                    messageType: int.parse(widget.messages.elementAt(index).messageType),
                    message: widget.messages.elementAt(index).content,
                    profileImg: (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                        ? widget.user.image
                        : '${GlobalConfiguration().getString('api_base_url')}images/logo.png'
                );
              }),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/chat_users.dart';
import '../repository/chat_users_repository.dart' as chatUsersRepo;
import '../repository/user_repository.dart' as userRepo;

class ChatUsersController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<ChatUsers> chatUsers = <ChatUsers>[];

  ChatUsersController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForMessageUsers();
  }

  void listenForMessageUsers() async {
    chatUsersRepo.getMessageUsers().then((_messageUsers){
      if(_messageUsers.isNotEmpty) {
        for(var messageUser in _messageUsers){
          setState(() {
            chatUsers.add(ChatUsers.fromJSON(messageUser));
          });
        }
      }
    });
  }

  Future<void> refreshChatUsers() async {
    setState(() {
      chatUsers = <ChatUsers>[];
    });
    await listenForMessageUsers();
  }
}
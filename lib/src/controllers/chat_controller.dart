import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sahem/src/repository/user_repository.dart';

import '../models/message.dart';
import '../models/question.dart';
import '../models/answer.dart';
import '../repository/settings_repository.dart';
import '../repository/chat_repository.dart' as chatRepo;

class ChatController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Message> messages = <Message>[];
  List<Question> questions = <Question>[];
  Answer answer = Answer();
  ScrollController scrollController = new ScrollController();
  TextEditingController sendMessageController = new TextEditingController();
  String type1 = '0';
  String type2 = '0';
  int length;
  String userRole;
  bool condition;

  ChatController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForQuestion();
  }

  void sendMessage({String userId, String content, String receive, String messageType, String type, int index}) {
    chatRepo.sendMessage(userId, content, receive, messageType, type).then((value) {
      if(value.content.isNotEmpty) {
        setState(() {
          if(messages.length != 0) {
            if(messages.last.isFromSender && value.isFromSender){
              typeMessage();
              messages.last.messageType = type2;
            } else if (!messages.last.isFromSender && !value.isFromSender) {
              typeReceiveMessage();
              messages.last.messageType = type2;
            }
            messages.add(value);
          } else {
            messages.add(value);
          }
        });
        type1 = '0';
        type2 = '0';
      }
    });
  }

  void listenForMessages({String userId}) async {
    chatRepo.getMessages(userId).then((_messages){
      if(_messages.isNotEmpty) {
        for(var message in _messages){
          setState(() => messages.add(Message.fromJSON(message)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  void listenForQuestion() async {
    chatRepo.getQuestions().then((_questions){
      if(_questions.isNotEmpty) {
        for(var question in _questions){
          setState(() => questions.add(Question.fromJSON(question)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  void getAnswer({String userId, String questionId}) async {
    chatRepo.getAnswer(questionId).then((_answer){
      if(_answer.id.isNotEmpty) {
        setState(() => answer = _answer);
      }
    }).whenComplete(() {
      typeReceiveMessage();
      sendMessage(
          userId: userId,
          content: setting.value.mobileLanguage.value == Locale('en', '')
              ? answer.answerEn
              : answer.answerEn,
          receive: 'receive',
          messageType: '0',
          type: '0'
      );
    }).catchError((e){
      print(e);
    });
  }

  void typeMessage(){
    if(messages.isNotEmpty) {
      if(!messages.last.isFromSender) {
        type1 = '0';
        type2 = '0';
      } else if(messages.length >= 2) {
        if(messages.last.isFromSender && messages.elementAt((messages.length - 1)).isFromSender
          && messages.elementAt((messages.length - 2)).isFromSender) {
          type1 = '3';
          type2 = '2';
        } else if(messages.last.isFromSender) {
          type1 = '3';
          type2 = '1';
        } else {
          type1 = '0';
          type2 = '0';
        }
      } else if(messages.last.isFromSender) {
        type1 = '3';
        type2 = '1';
      }
    } else {
      type1 = '0';
      type2 = '0';
    }
  }

  void typeReceiveMessage() {
    if(messages.isNotEmpty) {
      if(messages.last.isFromSender) {
        type1 = '0';
        type2 = '0';
      } else if(messages.length >= 2) {
        if(!messages.last.isFromSender && !messages.elementAt((messages.length - 1)).isFromSender
            && !messages.elementAt((messages.length - 2)).isFromSender) {
          type1 = '3';
          type2 = '2';
        } else if(!messages.last.isFromSender) {
          type1 = '3';
          type2 = '1';
        } else {
          type1 = '0';
          type2 = '0';
        }
      } else if(!messages.last.isFromSender) {
        type1 = '3';
        type2 = '1';
      }
    } else {
      type1 = '0';
      type2 = '0';
    }
  }

  void getCondition() {
    if(messages.isEmpty)
      condition = true;
    else
     condition = (length < 5 && (userRole !='1' || userRole !='2'));
  }

  Future<void> refreshChat() async {
    setState(() {
      messages = <Message>[];
    });
    listenForMessages();
  }
}
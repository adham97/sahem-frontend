import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/message.dart';
import '../models/answer.dart';
import '../repository/user_repository.dart';

Future<Message> sendMessage(String userId, String content, String receive, String messageType, String type) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}message.php';
  final client = new http.Client();

  print(content);
  Message result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': userId,
        'is_from_sender': receive == 'receive' ? '0' : '1',
        'content': content,
        'message_type': messageType,
        'type': type
      }
  );

  if (response.statusCode == 200) {
    result = Message.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<List> getMessages(String userId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}message.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': userId
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<List> getQuestions() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}question.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
     'token_id': currentUser.value.token
    }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<Answer> getAnswer(String questionId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}answer.php';
  final client = new http.Client();

  Answer result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'question_id': questionId
      }
  );

  if (response.statusCode == 200) {
    result = Answer.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}
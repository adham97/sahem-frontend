import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../repository/user_repository.dart';

Future<List> getMessageUsers() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}message_user.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
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
        'user_id': currentUser.value.id
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

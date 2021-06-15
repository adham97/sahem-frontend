import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/models/notification.dart';

import '../repository/user_repository.dart';

Future<List<Notifications>> getNotifications() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}notifications.php';
  final client = new http.Client();

  List<Notifications> result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'role': currentUser.value.userRole,
        'user_id': currentUser.value.id
      }
  );
  if (response.statusCode == 200) {
    result = (json.decode(response.body)['message'] as List).map<Notifications>((json) => new Notifications.fromJSON(json)).toList();
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> updateStatus(String notificationsId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}notifications.php';
  final client = new http.Client();

  String result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'notifications_id': notificationsId
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<int> getNotificationsCount() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}notifications.php';
  final client = new http.Client();

  int result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': currentUser.value.id,
        'role': currentUser.value.userRole,
        'count': 'count'
      }
  );
  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}
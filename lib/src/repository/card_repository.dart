import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/card.dart';
import '../repository/user_repository.dart';

Future<String> insertCard(Cards card) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}cards.php';
  final client = new http.Client();

  String result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': currentUser.value.id,
        'option': 'insert',
        'card': jsonEncode(card.toMap())
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<List> selectCard() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}card.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': currentUser.value.id,
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> getCard() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}cards.php';
  final client = new http.Client();

  String result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': currentUser.value.id,
        'option': 'get_card'
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

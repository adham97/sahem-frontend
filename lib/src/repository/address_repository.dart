import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
import '../repository/user_repository.dart';

Future<String> insertAddress(Address address) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}address.php';
  final client = new http.Client();

  String result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'user_id': currentUser.value.id,
        'option': 'insert',
        'address': json.encode(address.toMap())
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}
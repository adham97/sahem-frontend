import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/repository/user_repository.dart';

import '../models/platform.dart';

Future<List> getCategory(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}platform.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
      'token_id': currentUser.value.token,
      'platform_categories_id': id
    }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<Platform> getPlatform(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}platform.php';
  final client = new http.Client();

  Platform result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'platform_id': id
      }
  );

  if (response.statusCode == 200) {
    result = Platform.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}

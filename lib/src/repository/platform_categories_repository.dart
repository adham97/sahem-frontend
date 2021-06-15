import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/models/platform_categories.dart';
import 'package:sahem/src/repository/user_repository.dart';

Future<List> getPlatformCategories() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}platform_categories.php';
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

Future<PlatformCategories> getPlatformCategorie(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}platform_categories.php';
  final client = new http.Client();

  PlatformCategories result;
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
      'platform_categories_id': id
    }
  );

  if (response.statusCode == 200) {
    result = PlatformCategories.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}
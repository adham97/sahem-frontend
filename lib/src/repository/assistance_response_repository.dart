import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/models/assistance.dart';

import '../models/platform.dart';
import '../models/platform_categories.dart';
import '../repository/user_repository.dart';

Future<PlatformCategories> getPlatformCategories(String platformCategoriesId) async{
  final String url = '${GlobalConfiguration().getString('api_base_url')}assistance_response.php';
  final client = new http.Client();

  PlatformCategories result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'platform_categories_id': platformCategoriesId,
      }
  );

  if (response.statusCode == 200) {
    result = PlatformCategories.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> assistanceResponse(Assistance assistance, String acceptanceId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}assistance_response.php';
  final client = new http.Client();

  String result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'assistance': json.encode(assistance.toMap()),
        'acceptance_id': acceptanceId,
       }
  );
  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> insertPlatform(Platform platform) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}insert_platform.php';
  final client = new http.Client();

  String result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'platform': json.encode(platform.toMap())
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}


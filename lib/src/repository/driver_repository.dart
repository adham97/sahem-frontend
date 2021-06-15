import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/models/driver.dart';

import '../repository/user_repository.dart';

Future<List<Driver>> getDriverNotifications() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}driver.php';
  final client = new http.Client();

  List<Driver> result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'role': currentUser.value.userRole,
      }
  );
  if (response.statusCode == 200) {
    result = (json.decode(response.body)['message'] as List).map<Driver>((json) => new Driver.fromJSON(json)).toList();
  } else {
    throw new Exception(response.body);
  }
  return result;
}
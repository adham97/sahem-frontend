import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/search.dart';
import '../repository/user_repository.dart';

Future<List<Search>> getSearch(String searchText) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}search.php';
  final client = new http.Client();

  List<Search> result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'search_text': searchText
      }
  );

  if (response.statusCode == 200) {
    result = (json.decode(response.body)['message'] as List).map<Search>((json) => new Search.fromJSON(json)).toList();
  } else {
    throw new Exception(response.body);
  }
  return result;
}

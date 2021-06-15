import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/users.dart';
import '../repository/user_repository.dart';

ValueNotifier<Users> user = new ValueNotifier(Users());

Future<List> getUsers() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}users.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
      'user_role': currentUser.value.userRole,
      'token_id': currentUser.value.token,
      'option': 'users'
    }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<List> getRoles() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}users.php';
  final client = new http.Client();

  List result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'user_role': currentUser.value.userRole,
        'token_id': currentUser.value.token,
        'option': 'roles'
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['message'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<Users> getUser(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}users.php';
  final client = new http.Client();

  Users result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'user_role': currentUser.value.userRole,
        'token_id': currentUser.value.token,
        'option': 'user',
        'user_id': id
      }
  );

  if (response.statusCode == 200) {
    result = Users.formJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> updateRole(String id, String role) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}users.php';
  final client = new http.Client();

  String result;
  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'user_role': currentUser.value.userRole,
        'token_id': currentUser.value.token,
        'option': 'update',
        'user_id': id,
        'role': role
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}
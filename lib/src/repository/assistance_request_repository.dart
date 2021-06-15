import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/assistance.dart';
import '../models/address.dart';
import '../models/card.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

Future<String> insertAssistance(Assistance assistance, Cards cards, Address address) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}assistance.php';
  final client = new http.Client();

  String result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'assistance': json.encode(assistance.toMap()),
        'option': setting.value.mobileLanguage.value == Locale('en', '') ? 'en' : 'ar',
        'name': '${currentUser.value.firstName}_${currentUser.value.lastName}.png',
        'card': json.encode(cards.toMap()),
        'address': json.encode(address.toMap())
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}


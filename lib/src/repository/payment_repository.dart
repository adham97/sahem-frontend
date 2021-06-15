import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/payment.dart';
import '../repository/user_repository.dart';

Future<String> insertPayment(Payment payment) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}payments.php';
  final client = new http.Client();

  print(json.encode(payment.toMap()));
  String result;
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
      'token_id': currentUser.value.token,
      'payment': json.encode(payment.toMap())
    }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}
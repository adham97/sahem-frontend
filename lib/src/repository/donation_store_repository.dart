import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/donation_store.dart';
import '../models/address.dart';
import '../repository/user_repository.dart';
import '../repository/settings_repository.dart';

Future<List<DonationStore>> getDonations() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}donation_store.php';
  final client = new http.Client();

  List<DonationStore> result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'select_donation_store': 'donation_store'
      }
  );
  if (response.statusCode == 200) {
    result = (json.decode(response.body)['message'] as List).map<DonationStore>((json) => new DonationStore.fromJSON(json)).toList();
  } else {
    throw new Exception(response.body);
  }
  return result;
}

Future<String> insertDonation(DonationStore donationStore, Address address) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}donation_store.php';
  final client = new http.Client();

  String result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'option': setting.value.mobileLanguage.value == Locale('en', '') ? 'en' : 'ar',
        'donation_store': json.encode(donationStore.toMap()),
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

Future<String> idNeedDonation(String donationStoreId) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}donation_store.php';
  final client = new http.Client();

  String result;

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token,
        'i_need_it': 'i_need_it',
        'donation_store_id': donationStoreId,
        'user_id': currentUser.value.id
      }
  );

  if (response.statusCode == 200) {
    result = json.decode(response.body)['result'];
  } else {
    throw new Exception(response.body);
  }
  return result;
}
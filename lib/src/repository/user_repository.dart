import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:sahem/src/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/credit_card.dart';
*/
import '../models/user.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
ValueNotifier<User> tempUser = new ValueNotifier(User());

Future<User> login(User user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}login.php';
  final client = new http.Client();

  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'email_phone': user.email != null ? user.email : user.phone,
        'password': user.password,
      }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> register(User user) async {
  // ignore: deprecated_member_use This email is already used
  final String url = '${GlobalConfiguration().getString('api_base_url')}register.php';
  final client = new http.Client();

  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader:'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'first_name': user.firstName,
        'father_name': user.fatherName,
        'grandfather_name': user.grandfatherName,
        'last_name': user.lastName,
        'email': user.email,
        'password': user.password,
        'identify_id': user.identifyId,
        'phone': user.phone,
        'city': user.city,
        'street': user.street,
      }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> resetPassword(User user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}send_reset_link_email';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw new Exception(response.body);
  }
}

Future<void> logout() async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}logout.php';
  final client = new http.Client();

  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'token_id': currentUser.value.token
      }
  );
  if (response.statusCode == 200) {
    currentUser.value = new User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  } else {
    throw new Exception(response.body);
  }
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['message'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)['message']));
  }
}
/*
Future<void> setCreditCard(CreditCard creditCard) async {
  if (creditCard != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('credit_card', json.encode(creditCard.toMap()));
  }
}
*/
Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value = User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}
/*
Future<CreditCard> getCreditCard() async {
  CreditCard _creditCard = new CreditCard();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('credit_card')) {
    _creditCard = CreditCard.fromJSON(json.decode(await prefs.get('credit_card')));
  }
  return _creditCard;
}
*/
Future<User> update(User user) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}update_user.php';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: {
      'user_id': user.id,
      'first_name': user.firstName,
      'father_name': user.fatherName,
      'grandfather_name': user.grandfatherName,
      'last_name': user.lastName,
      'email': user.email,
      'identify_id': user.identifyId,
      'phone': user.phone,
      'city': user.city,
      'street': user.street,
      'user_role': user.userRole,
      'token_id': user.token
    }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> uploadUserImage(String base64Image) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}upload_user_image.php';
  final client = new http.Client();

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'user_id': currentUser.value.id,
        'token_id': currentUser.value.token,
        'image': base64Image,
        'name': '${currentUser.value.firstName}_${currentUser.value.lastName}.png',
      }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> uploadIdPhoto(String base64Image) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}upload_user_id_photo.php';
  final client = new http.Client();

  final response = await client.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8'},
      body: {
        'user_id': currentUser.value.id,
        'token_id': currentUser.value.token,
        'id_photo': base64Image,
        'name': '${currentUser.value.firstName}_${currentUser.value.lastName}_id_photo.png',
      }
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<User> getUser(String id) async {
  final String url = '${GlobalConfiguration().getString('api_base_url')}users.php';
  final client = new http.Client();

  User result;
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
    result = User.fromJSON(json.decode(response.body)['message']);
  } else {
    throw new Exception(response.body);
  }
  return result;
}

/*
Future<Stream<Address>> getAddresses() async {
  User _user = currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=updated_at&sortedBy=desc';
  print(url);
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
    return Address.fromJSON(data);
  });
}

Future<Address> addAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> updateAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(address.toMap()),
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

Future<Address> removeDeliveryAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.delete(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  return Address.fromJSON(json.decode(response.body)['data']);
}

 */
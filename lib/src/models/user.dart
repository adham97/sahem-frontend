import 'package:global_configuration/global_configuration.dart';

class User {
  String id;
  String firstName;
  String fatherName;
  String grandfatherName;
  String lastName;
  String email;
  String password;
  String identifyId;
  String phone;
  String city;
  String street;
  String userRole;
  String image;
  String idPhoto;
  bool online;
  String token;
  bool auth;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['user_id'].toString();
      firstName = jsonMap['first_name'];
      fatherName = jsonMap['father_name'];
      grandfatherName = jsonMap['grandfather_name'];
      lastName = jsonMap['last_name'];
      email = jsonMap['email'];
      identifyId = jsonMap['identify_id'];
      phone = jsonMap['phone'];
      city = jsonMap['city'];
      street = jsonMap['street'];
      userRole = jsonMap['user_role'].toString();
      image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
      idPhoto = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['id_photo']}';
      online = jsonMap['online'] == '1' ? true : false;
      token = jsonMap['token_id'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    var user = new Map<String, dynamic>();
    map['user_id'] = id;
    map["first_name"] = firstName;
    map["father_name"] = fatherName;
    map["grandfather_name"] = grandfatherName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["password"] = password;
    map["identify_id"] = identifyId;
    map["phone"] = phone;
    map["city"] = city;
    map["street"] = street;
    map["user_role"] = userRole;
    map["token_id"] = token;
    user["user_info"] = map;
    return user;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
/*
  bool profileCompleted() {
    return address != null && address != '' && phone != null && phone != '';
  }

 */
}

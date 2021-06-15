import 'package:global_configuration/global_configuration.dart';

class Users {
  String userId;
  String firstName;
  String fatherName;
  String grandfatherName;
  String lastName;
  String email;
  String identifyId;
  String phone;
  String city;
  String street;
  String roleId;
  String roleName;
  String image;

  Users();

  Users.formJSON(Map<String, dynamic> jsonMap) {
    try {
      userId = jsonMap['user_id'].toString();
      firstName = jsonMap['first_name'];
      fatherName = jsonMap['father_name'];
      grandfatherName = jsonMap['grandfather_name'];
      lastName = jsonMap['last_name'];
      email = jsonMap['email'];
      identifyId = jsonMap['identify_id'];
      phone = jsonMap['phone'];
      city = jsonMap['city'];
      street = jsonMap['street'];
      roleId = jsonMap['role_id'].toString();
      roleName = jsonMap['role_name'];
      image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
    } catch(e) {
      print(e);
    }
  }
}
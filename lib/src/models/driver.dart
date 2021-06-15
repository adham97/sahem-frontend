import 'package:global_configuration/global_configuration.dart';

import '../models/address.dart';
import '../models/user.dart';

class Driver {
  String id;
  User user;
  String title;
  String typeId;
  bool statusId;
  DateTime date;
  String name;
  String description;
  Address address;
  String image;

  Driver();

  Driver.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    user = User.fromJSON(jsonMap['user']);
    title = jsonMap['title'];
    typeId = jsonMap['type_id'];
    statusId = jsonMap['status_id'] == '1' ? true : false;
    date = DateTime.parse(jsonMap['date']);
    name = jsonMap['name'];
    description = jsonMap['description'];
    address = Address.fromJSON(jsonMap['address']);
    image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
  }
}
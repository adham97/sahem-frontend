class Address {
  String id;
  String userId;
  String city;
  String street;
  String latitude;
  String longitude;

  Address();

  Address.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['address_id'];
      userId = jsonMap['user_id'];
      city = jsonMap['city'];
      street = jsonMap['street'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = userId;
    map['city'] = city;
    map["street"] = street;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    return map;
  }
}
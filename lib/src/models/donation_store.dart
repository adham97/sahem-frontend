import 'package:global_configuration/global_configuration.dart';

class DonationStore {
  String id;
  String userId;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String addressId;
  String image;
  String status;

  DonationStore();

  DonationStore.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['donation_store_id'];
      userId = jsonMap['user_id'];
      nameEn = jsonMap['name_en'];
      nameAr = jsonMap['name_ar'];
      descriptionEn = jsonMap['description_en'];
      descriptionAr = jsonMap['description_ar'];
      addressId = jsonMap['address_id'];
      image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
      status = jsonMap['status'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_id"] = userId;
    map["name_en"] = nameEn;
    map["name_ar"] = nameAr;
    map["description_ar"] = descriptionEn;
    map["description_en"] = descriptionAr;
    map["address_id"] = addressId;
    map["image"] = image;
    map["status"] = status;
    return map;
  }
}
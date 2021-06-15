import 'package:global_configuration/global_configuration.dart';

class Assistance {
  String id;
  String userId;
  String userIdPhoto;
  String platformCategoriesId;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String acceptanceId;
  String cardId;
  String addressId;

  Assistance();

  Assistance.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['assistance_id'];
      userId = jsonMap['user_id'];
      userIdPhoto = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['user_id_photo']}';
      platformCategoriesId = jsonMap['platform_categories_id'];
      nameEn = jsonMap['name_en'];
      nameAr = jsonMap['name_ar'];
      descriptionEn = jsonMap['description_en'];
      descriptionAr = jsonMap['description_ar'];
      acceptanceId = jsonMap['acceptance_id'];
      cardId = jsonMap['card_id'];
      addressId = jsonMap['address_id'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['assistance_id'] = id;
    map["user_id"] = userId;
    map["user_id_photo"] = userIdPhoto;
    map["platform_categories_id"] = platformCategoriesId;
    map["name_en"] = nameEn;
    map["name_ar"] = nameAr;
    map["description_ar"] = descriptionEn;
    map["description_en"] = descriptionAr;
    map["acceptance_id"] = acceptanceId;
    map["card_id"] = cardId;
    map["address_id"] = addressId;
    return map;
  }
}
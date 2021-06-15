class Platform {
  String id;
  String platformCategoriesId;
  String nameEn;
  String nameAr;
  String descriptionEn;
  String descriptionAr;
  String acceptanceId;
  String userId;
  DateTime date;

  Platform();

  Platform.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      platformCategoriesId = jsonMap['platform_categories_id'];
      nameEn = jsonMap['name_en'];
      nameAr = jsonMap['name_ar'];
      descriptionEn = jsonMap['description_en'];
      descriptionAr = jsonMap['description_ar'];
      acceptanceId = jsonMap['acceptance_id'];
      userId = jsonMap['user_id'];
      date = DateTime.parse(jsonMap['date']);
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['platform_id'] = id;
    map["platform_categories_id"] = platformCategoriesId;
    map["name_en"] = nameEn;
    map["name_ar"] = nameAr;
    map["description_en"] = descriptionEn;
    map["description_ar"] = descriptionAr;
    map["acceptance_id"] = acceptanceId;
    map["user_id"] = userId;
    return map;
  }
}

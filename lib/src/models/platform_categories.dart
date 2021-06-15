import 'package:global_configuration/global_configuration.dart';

class PlatformCategories {
 String id;
 String nameEn;
 String nameAr;
 String image;

 PlatformCategories();

 PlatformCategories.fromJSON(Map<String, dynamic> jsonMap) {
  try {
   id = jsonMap['id'].toString();
   nameEn = jsonMap['name_en'];
   nameAr = jsonMap['name_ar'];
   image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
  } catch (e) {
   print(e);
  }
 }

}

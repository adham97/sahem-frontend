//import 'package:global_configuration/global_configuration.dart';
class Media {
  String url;

  Media() {
    url = 'assets/img/unknown.png';
  }

  Media.fromJSON(Map<String, dynamic> jsonMap) {
   try {
    url = jsonMap['url'];
    } catch (e) {
      url = 'assets/img/unknown.png';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["url"] = url;
    return map;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

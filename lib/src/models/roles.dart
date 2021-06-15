class Roles {
  String id;
  String name;

  Roles();

  Roles.formJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
    } catch (e) {
      print(e);
    }
  }
}
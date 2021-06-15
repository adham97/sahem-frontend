import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/platform_categories.dart';
import '../repository/platform_categories_repository.dart';

class HomeController extends ControllerMVC {
  List<PlatformCategories> platformCategories = <PlatformCategories>[];
  String index;

  HomeController() {
    listenForPlatformCategories();
    if(platformCategories.isNotEmpty) {
      index = platformCategories.elementAt(0).id;
    }
  }

  Future<void> listenForPlatformCategories() async {
    getPlatformCategories().then((categories){
      if(categories.isNotEmpty) {
        for(var category in categories){
          setState(() => platformCategories.add(PlatformCategories.fromJSON(category)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<void> refreshHome() async {
    setState(() {
      platformCategories = <PlatformCategories>[];
    });
    await listenForPlatformCategories();
  }
}

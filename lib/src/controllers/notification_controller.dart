import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sahem/src/models/address.dart';
import 'package:sahem/src/models/platform.dart';
import 'package:sahem/src/models/platform_categories.dart';
import 'package:sahem/src/repository/platform_categories_repository.dart';
import 'package:sahem/src/repository/platform_repository.dart';

import '../models/notification.dart';
import '../repository/notification_repository.dart';

class NotificationController extends ControllerMVC {
  final List<Notifications> notifications = [];
  PlatformCategories platformCategories;
  Platform platform;

  NotificationController() {
    // getNotification();
    platformCategories = new PlatformCategories();
    platform = new Platform();
  }
  //
  // Future<void> getNotification() async {
  //   getNotifications().then((_notifications){
  //     if(_notifications.isNotEmpty) {
  //       for(var notification in _notifications){
  //         setState(() => notifications.add(Notification.fromJSON(notification)));
  //       }
  //     }
  //   }).catchError((e){
  //     print(e);
  //   });
  // }

  void listenForPlatformCategory({String id}) async {
    getPlatformCategorie(id).then((plat){
      if(plat.id.isNotEmpty) {
        setState(() => platformCategories = plat);
      }
    }).catchError((e){
      print(e);
    });
  }

  void listenForPlatform({String id}) async {
    getPlatform(id).then((plat){
      if(plat.id.isNotEmpty) {
        setState(() => platform = plat);
      }
    }).catchError((e){
      print(e);
    });
  }
}

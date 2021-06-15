import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/platform.dart';
import '../repository/platform_repository.dart';

class PlatformController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Platform> platforms = <Platform>[];

  PlatformController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForCategory({String id, String message}) async {
    getCategory(id).then((plat){
      if(plat.isNotEmpty) {
        for(var platform in plat){
          setState(() => platforms.add(Platform.fromJSON(platform)));
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  Future<void> refreshCategory() async {
    setState(() {
      platforms = <Platform>[];
    });
    await listenForCategory();
  }
}

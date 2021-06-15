import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/settings_repository.dart' as settingRepo;

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0};
  }

  @override
  void initState() {
    super.initState();
    settingRepo.setting.addListener(() {
      if (settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 50;
        progress?.notifyListeners();
      }
    });
  }
}

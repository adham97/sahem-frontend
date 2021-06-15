import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/assistance.dart';
import '../models/platform_categories.dart';
import '../models/user.dart';
import '../repository/assistance_response_repository.dart' as assistanceRepo;

class AssistanceResponseController extends ControllerMVC {
  Assistance assistance;
  User user;
  PlatformCategories platformCategories;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  String acceptanceId;

  AssistanceResponseController() {
    assistance = new Assistance();
    user = User();
    platformCategories = new PlatformCategories();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void assistanceResponse() async {
    assistanceRepo.assistanceResponse(assistance, acceptanceId).then((value) {
      if (value != 'success') {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(S.of(context).check_your_internet_connection),
        ));
      }
    }).whenComplete(() {
      Helper.hideLoader(loader);
      Navigator.of(context).pushReplacementNamed('/Notifications');
    });
  }
}

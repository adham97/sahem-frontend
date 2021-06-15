import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/driver.dart';
import '../repository/driver_repository.dart';

class DriverController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Driver> drivers = <Driver>[];

  DriverController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<void> refreshNotification() async {
    setState(() {
      drivers = <Driver>[];
    });
  }
}

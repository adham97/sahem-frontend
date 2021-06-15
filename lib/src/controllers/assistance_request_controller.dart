import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/platform_categories.dart';
import '../models/assistance.dart';
import '../models/address.dart';
import '../models/card.dart';
import '../repository/platform_categories_repository.dart';
import '../repository/assistance_request_repository.dart' as assistanceRepo;
import '../repository/user_repository.dart';

class AssistanceRequestController extends ControllerMVC {
  List<PlatformCategories> platformCategories = <PlatformCategories>[];
  String index;
  Assistance assistance;
  String base64Image;
  File imageFile;
  String urlImage;
  bool loading = false;
  GlobalKey<FormState> platformFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;
  Cards card;
  Address address;
  Position currentPosition;
  String currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  AssistanceRequestController() {
    assistance = new Assistance();
    assistance.userId = currentUser.value.id;
    assistance.acceptanceId = '1';
    listenForPlatformCategories();
    if(platformCategories.isNotEmpty) {
      index = '0';
    }
    loader = Helper.overlayLoader(context);
    platformFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    card = new Cards();
    address = new Address();
    address.latitude = '0';
    address.longitude = '0';
    getCurrentLocation();
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

  void insertAssistance() async {
    FocusScope.of(context).unfocus();
    if (platformFormKey.currentState.validate()) {
      platformFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      assistanceRepo.insertAssistance(assistance, card, address).then((value) {
        print(value);
      }).whenComplete(() {
        Helper.hideLoader(loader);
        Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
      });
    }
    else {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(S.of(context).check_your_internet_connection),
      ));
    }
  }

  void insertAddress() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude
    );
    Placemark place = p[0];
    setState(() {
      currentAddress = "${place.locality}, ${place.postalCode}";
      address.userId = currentUser.value.id;
      address.city = currentUser.value.city;
      address.street = currentUser.value.street;
      address.latitude = currentPosition.latitude.toString();
      address.longitude = currentPosition.longitude.toString();
    });
  }

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude
      );
      Placemark place = p[0];
      setState(() {
        currentAddress = "${place.locality}, ${place.postalCode}";
      });
    } catch (e) {
      print(e);
    }
  }
}

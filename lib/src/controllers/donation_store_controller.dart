import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:geolocator/geolocator.dart';

import '../../generated/l10n.dart';
import '../models/donation_store.dart';
import '../models/address.dart';
import '../repository/donation_store_repository.dart' as donationRepo;
import '../repository/user_repository.dart';

class DonationStoreController extends ControllerMVC {
  DonationStore donationStore;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> donationFormKey;
  Address address;
  Position currentPosition;
  String currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  DonationStoreController() {
    donationStore = new DonationStore();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    donationFormKey = new GlobalKey<FormState>();
    address = new Address();
    address.latitude = '0';
    address.longitude = '0';
    getCurrentLocation();
  }

  void insertDonation() async {
    FocusScope.of(context).unfocus();
    if (donationFormKey.currentState.validate()) {
      donationFormKey.currentState.save();
      donationRepo.insertDonation(donationStore, address).then((value) {
        if(value == 'success') {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.of(context).donation_added_successfully),
          ));
        }
      }).whenComplete(() {
        new Timer(const Duration(milliseconds: 400), () {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
        });
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

  Future<void> refreshDonationStore() async {}
}

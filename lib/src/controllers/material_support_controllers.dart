import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/payment.dart';
import '../repository/user_repository.dart';
import '../repository/address_repository.dart' as addressRepo;
import '../repository/payment_repository.dart' as paymentRepo;

class MaterialSupportController extends ControllerMVC {
  Address address;
  Payment payment;
  Position currentPosition;
  String currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  GlobalKey<FormState> paymentFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry loader;

  MaterialSupportController() {
    address = new Address();
    payment = new Payment();
    getCurrentLocation();
    loader = Helper.overlayLoader(context);
    paymentFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void insertAddress() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude
    );
    Placemark place = p[0];
    setState(() {
      currentAddress = "${place.locality}, ${place.postalCode}";
      address.city = place.locality;
      address.street = place.postalCode;
      // address.country = place.country;
      address.latitude = currentPosition.latitude.toString();
      address.longitude = currentPosition.longitude.toString();
      address.userId = currentUser.value.id;
    });
    if(address.longitude != null && address.latitude != null)
    addressRepo.insertAddress(address).then((addressId) {
      setState((){
        payment.addressId = '13';
      });
    });
  }

  void insertPayment() async {
    // insertAddress();
    setState((){
      payment.addressId = '13';
    });
    FocusScope.of(context).unfocus();
    if (paymentFormKey.currentState.validate()) {
      paymentFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      paymentRepo.insertPayment(payment).then((value) {
        if (value == 'success') {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.of(context).your_request_has_been_sent_successfully),
          ));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.of(context).check_your_internet_connection),
          ));
        }
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
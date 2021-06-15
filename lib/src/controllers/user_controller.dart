//import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;
import '../helpers/helper.dart';
import 'package:http/http.dart' as http;
/*

*/
class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  //FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    /*
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
    }).catchError((e) {
      print('Notification not configured');
    });

     */
  }



/*
        setState(() {
          Toast.show("This is Toast messaget",
              context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM
          );
        });
 */

  void login() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.login(user).then((value) {
        if (value != null && value.token != null) {
          if(value.userRole == '4')
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Driver');
          else
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(S.of(context).wrong_email_or_password),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void register() async {
    user = repository.tempUser.value;
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.register(user).then((value) {
        if (value != null && value.token != null) {
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('ohh'),//Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('no'),//Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void updateUser({User user}) async {
    repository.update(user).then((value) {
      if (value != null && value.token != null) {
        Navigator.of(context).pushNamed('/Profile');
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(S.of(context).wrong_on_update_profile),
        ));
      }
    });

  }

  void resetPassword() {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(S.of(context).your_reset_link_has_been_sent_to_your_email),
            action: SnackBarAction(
              label: S.of(context).login,
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          loader.remove();
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(''),//Text(S.of(context).error_verify_email_settings),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/responsive.dart';
import '../repository/user_repository.dart';
import '../repository/settings_repository.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends StateMVC<RegisterWidget> {
  UserController _con;

  _RegisterWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: MediaQuery.of(context).size.width > mobile
      ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70),
            Image.asset(
              'assets/img/splash.png',
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]
              ),
              margin: EdgeInsets.symmetric(horizontal: 20,),
              padding: EdgeInsets.symmetric(vertical: 25 ,horizontal: 27),
              width: 500,
              child: Form(
                key: _con.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.firstName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.firstName != null ? tempUser.value.firstName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).first_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).first_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.fatherName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.fatherName != null ? tempUser.value.fatherName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).father_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).father_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.grandfatherName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.grandfatherName != null ? tempUser.value.grandfatherName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).grandfather_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).grandfather_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.lastName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.lastName != null ? tempUser.value.lastName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).last_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).last_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (input) => tempUser.value.identifyId = input,
                        validator: (input) => input.length == 0
                            ? S.of(context).it_cannot_be_left_blank
                            : input.length < 8
                            ? S.of(context).the_ID_number_is_incorrect
                            : null,
                        initialValue: tempUser.value.identifyId != null ? tempUser.value.identifyId : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).id_number,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).id_number,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.perm_identity, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          child:
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                _con.loginFormKey.currentState.save();
                                Navigator.of(context).pushNamed('/SecondRegister');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).next,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ],
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: setting.value.mobileLanguage.value == Locale('en', '')
                  ? 30
                  : 10,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Login');
                },
                child: Text(
                  S.of(context).sign_in,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70),
            Image.asset(
              'assets/img/splash.png',
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]
              ),
              margin: EdgeInsets.symmetric(horizontal: 20,),
              padding: EdgeInsets.symmetric(vertical: 25 ,horizontal: 27),
              width: config.App(context).appWidth(88),
              child: Form(
                key: _con.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.firstName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.firstName != null ? tempUser.value.firstName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).first_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).first_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.fatherName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.fatherName != null ? tempUser.value.fatherName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).father_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).father_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.grandfatherName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.grandfatherName != null ? tempUser.value.grandfatherName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).grandfather_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).grandfather_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => tempUser.value.lastName = input,
                        validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                        initialValue: tempUser.value.lastName != null ? tempUser.value.lastName : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).last_name,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).last_name,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (input) => tempUser.value.identifyId = input,
                        validator: (input) => input.length == 0
                            ? S.of(context).it_cannot_be_left_blank
                            : input.length < 8
                            ? S.of(context).the_ID_number_is_incorrect
                            : null,
                        initialValue: tempUser.value.identifyId != null ? tempUser.value.identifyId : '',
                        decoration: InputDecoration(
                          labelText: S.of(context).id_number,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).id_number,
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.perm_identity, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          child:
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: () {
                                _con.loginFormKey.currentState.save();
                                Navigator.of(context).pushNamed('/SecondRegister');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).next,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ],
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: setting.value.mobileLanguage.value == Locale('en', '')
                  ? 30
                  : 10,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Login');
                },
                child: Text(
                  S.of(context).sign_in,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/responsive.dart';
import '../controllers/user_controller.dart';
import '../repository/settings_repository.dart';


class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
   UserController _con;
  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    setting.value.brightness.value = Brightness.light;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        //resizeToAvoidBottomInset: false,
        //backgroundColor: Theme.of(context).primaryColor,
      body: MediaQuery.of(context).size.width > mobile
      ? ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        colors: [
                          Color(0xff00325b),
                          Color(0xff003866),
                          Color(0xff194b75),
                          Color(0xff325f84),
                        ]
                    )
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 300,),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50,
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                          )
                        ]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                    width: 500,
                    child: Column(
                      children: [
                        Form(
                            key: _con.loginFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (input) {
                                    if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input))
                                      _con.user.email = input;
                                    else if(RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(input))
                                      _con.user.phone = input;
                                  },
                                  validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).email,
                                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: 'example@gmail.com',
                                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                    prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _con.user.password = input,
                                  validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                                  obscureText: _con.hidePassword,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: '••••••••••••',
                                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                    prefixIcon: Icon( Icons.lock_outline, color: Theme.of(context).accentColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _con.hidePassword = !_con.hidePassword;
                                        });
                                      },
                                      color: Theme.of(context).focusColor,
                                      icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/ForgetPassword');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                child: Text(
                                  S.of(context).forgot_password,
                                  style: new TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // ignore: deprecated_member_use
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Theme.of(context).accentColor,)
                          ),
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            _con.login();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 90, bottom: 20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Register');
                      },
                      child: Text(
                        S.of(context).sign_up,
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
            ],
          ),
        ],
      ) : ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        colors: [
                          Color(0xff00325b),
                          Color(0xff003866),
                          Color(0xff194b75),
                          Color(0xff325f84),
                        ]
                    )
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 300,),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50,
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                          )
                        ]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                    width: config.App(context).appWidth(88),
                    child: Column(
                      children: [
                        Form(
                            key: _con.loginFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (input) {
                                    if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input))
                                      _con.user.email = input;
                                    else if(RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(input))
                                      _con.user.phone = input;
                                  },
                                  validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).email,
                                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: 'example@gmail.com',
                                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                    prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  onSaved: (input) => _con.user.password = input,
                                  validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                                  obscureText: _con.hidePassword,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: '••••••••••••',
                                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                    prefixIcon: Icon( Icons.lock_outline, color: Theme.of(context).accentColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _con.hidePassword = !_con.hidePassword;
                                        });
                                      },
                                      color: Theme.of(context).focusColor,
                                      icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                                    ),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/ForgetPassword');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                child: Text(
                                  S.of(context).forgot_password,
                                  style: new TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // ignore: deprecated_member_use
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Theme.of(context).accentColor,)
                          ),
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            _con.login();
                          },
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 110),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Register');
                      },
                      child: Text(
                        S.of(context).sign_up,
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
            ],
          ),
        ],
      )
    );
  }
}

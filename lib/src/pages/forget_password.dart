import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class ForgetPasswordWidget extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends StateMVC<ForgetPasswordWidget> {

  UserController _con;

  _ForgetPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
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
                    margin: EdgeInsets.only(top: 300,),
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                    width: config.App(context).appWidth(88),
                    child: Form(
                      key: _con.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => _con.user.email = input,
                            validator: (input) => !input.contains('@') ? S.of(context).email_to_reset_password : null,
                            decoration: InputDecoration(
                              labelText: S.of(context).email,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'example@gmail.com',
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 30),
                          // ignore: deprecated_member_use
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Theme.of(context).accentColor,)
                            ),
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              S.of(context).send_password_reset_link,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16
                              ),
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              _con.resetPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 160,),
                  Column(
                    children: [
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Login');
                        },
                        textColor: Theme.of(context).hintColor,
                        child: Text(
                          S.of(context).sign_in,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Register');
                        },
                        child: RichText(
                          text: TextSpan(
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: S.of(context).dont_have_an_account,),
                              new TextSpan(text: ' '),
                              new TextSpan(
                                  text: S.of(context).sign_up,
                                  style: new TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )

            ],
          ),
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart';

class SecondRegisterWidget extends StatefulWidget {
  @override
  _SecondRegisterWidgetState createState() => _SecondRegisterWidgetState();
}

class _SecondRegisterWidgetState extends StateMVC<SecondRegisterWidget> {
  UserController _con;

  _SecondRegisterWidgetState() : super(UserController()) {
    _con = controller;
  }

  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 120),
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical:25 ,horizontal: 27),
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
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => tempUser.value.email = input,
                            validator: (input) {
                              if(input.isEmpty)
                                return S.of(context).it_cannot_be_left_blank;
                              else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input))
                                return S.of(context).the_email_you_entered_is_not_valid;
                              else
                                return null;
                            },
                            initialValue: tempUser.value.email != null ? tempUser.value.email : '',
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
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _con.hidePassword,
                            onSaved: (input) => tempUser.value.password = input,
                            validator: (input) {
                              if(input.isEmpty)
                                return S.of(context).it_cannot_be_left_blank;
                              else if(input.length < 6)
                                return S.of(context).password_must_have_at_least_characters;
                              else
                                return null;
                            },
                            //initialValue: tempUser.value.password != null ? tempUser.value.password : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).password,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: '••••••••••••',
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
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
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            validator: (input) {
                              if (input.isEmpty)
                                return S.of(context).it_cannot_be_left_blank;
                              else if (input != _passwordController.text) {
                                return S.of(context).password_does_not_match;
                              }
                              else
                                return null;
                            },
                            initialValue: tempUser.value.password != null ? tempUser.value.password : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).conform_password,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: '••••••••••••',
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
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
                            keyboardType: TextInputType.phone,
                            onSaved: (input) => tempUser.value.phone = input,
                            validator: (input) => input.length < 6 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: tempUser.value.phone != null ? tempUser.value.phone : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).phone,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).phone,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.phone_iphone_outlined, color: Theme.of(context).accentColor),
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
                            onSaved: (input) => tempUser.value.city = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: tempUser.value.city != null ? tempUser.value.city : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).city,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).city,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.location_on_outlined, color: Theme.of(context).accentColor),
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
                            onSaved: (input) => tempUser.value.street = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: tempUser.value.street != null ? tempUser.value.street : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).street,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText:  S.of(context).street,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.location_on_outlined, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        // ignore: deprecated_member_use
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              side: BorderSide(color: Theme.of(context).accentColor,)
                          ),
                          height: 45,
                          child: Text(
                            S.of(context).sign_up,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            _con.register();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Container(
                  width: 105,
                  //alignment: Alignment.bottomCenter,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        _con.loginFormKey.currentState.save();
                        Navigator.of(context).pushNamed('/Register');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            S.of(context).back,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
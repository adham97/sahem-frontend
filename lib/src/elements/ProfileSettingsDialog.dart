import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/user.dart';

class ProfileSettingsDialog extends StatefulWidget {
  final User user;
  final VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      S.of(context).profile_settings,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.firstName = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.firstName != null ? widget.user.firstName : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).first_name,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).first_name,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              //prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.fatherName = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.fatherName != null ? widget.user.fatherName : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).father_name,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).father_name,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              //prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.grandfatherName = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.grandfatherName != null ? widget.user.grandfatherName : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).grandfather_name,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).grandfather_name,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              //prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.lastName = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.lastName != null ? widget.user.lastName : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).last_name,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).last_name,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              //prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (input) => widget.user.identifyId = input,
                            validator: (input) => input.length == 0
                                ? S.of(context).it_cannot_be_left_blank
                                : input.length < 8
                                ? S.of(context).the_ID_number_is_incorrect
                                : null,
                            initialValue: widget.user.identifyId != null ? widget.user.identifyId : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).id_number,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).id_number,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => widget.user..email = input,
                            validator: (input) {
                              if(input.isEmpty)
                                return S.of(context).it_cannot_be_left_blank;
                              else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input))
                                return S.of(context).the_email_you_entered_is_not_valid;
                              else
                                return null;
                            },
                            initialValue: widget.user.email != null ? widget.user.email : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).email,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'example@gmail.com',
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onSaved: (input) => widget.user.phone = input,
                            validator: (input) => input.length < 6 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.phone != null ? widget.user.phone : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).phone,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).phone,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.city = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.city != null ? widget.user.city : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).city,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: S.of(context).city,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => widget.user.street = input,
                            validator: (input) => input.length < 3 ? S.of(context).it_cannot_be_left_blank : null,
                            initialValue: widget.user.street != null ? widget.user.street : '',
                            decoration: InputDecoration(
                              labelText: S.of(context).street,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText:  S.of(context).street,
                              hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 90,
                        child:  MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Color(0xffce2029),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            S.of(context).cancel,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 90,
                        child:  MaterialButton(
                          onPressed: _submit,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            S.of(context).save,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),

                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        S.of(context).edit,
        style: Theme.of(context).textTheme.headline4.merge(TextStyle(letterSpacing: 1.3)),
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      widget.onChanged();
      Navigator.pop(context);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/donation_store_controller.dart';
import '../helpers/app_config.dart' as config;
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class NewDonation extends StatefulWidget {
  @override
  _NewDonationState createState() => _NewDonationState();
}

class _NewDonationState extends StateMVC<NewDonation> {
  DonationStoreController _con;
  _NewDonationState() : super(DonationStoreController()) {
    _con = controller;
  }

  String hintText;

  Future<File> file;
  String base64Image;
  File tmpFile;

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
      file.then((value) {
        setState(() {
          tmpFile = value;
          base64Image = base64Encode(value.readAsBytesSync());
        });
      }).whenComplete(() => _con.donationStore.image = base64Image);
    });
  }

  @override
  void initState() {
    super.initState();
    _con.donationStore.userId = currentUser.value.id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: ValueListenableBuilder(
            valueListenable: setting,
            builder: (context, value, child) {
              return Text(
                S.of(context).add_donation,
                style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 25),
                  decoration: setting.value.brightness.value == Brightness.light
                      ? BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]
                  )
                      : BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  width: config.App(context).appWidth(88),
                  child: Column(
                    children: [
                      Form(
                        key: _con.donationFormKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    S.of(context).donation_name,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                )
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) {
                                if(input.isNotEmpty){
                                  setting.value.mobileLanguage.value == Locale('en', '')
                                      ? _con.donationStore.nameEn = input
                                      : _con.donationStore.nameAr = input;
                                }
                              },
                              validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                hintText: S.of(context).donation_name,
                                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    S.of(context).description,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                )
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 4,
                              maxLines: 4,
                              onSaved: (input) {
                                if(input.isNotEmpty){
                                  setting.value.mobileLanguage.value == Locale('en', '')
                                      ? _con.donationStore.descriptionEn = input
                                      : _con.donationStore.descriptionAr = input;
                                }
                              },
                              validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: S.of(context).description,
                                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                //prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  S.of(context).parcel_photo,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              padding: EdgeInsets.only(left: 20, right: 5),
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Theme.of(context).hintColor.withOpacity(0.2),
                                    )
                                  ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2.8,
                                    child: Text(
                                      _con.donationStore.image == null
                                          ? S.of(context).no_image_chosen
                                          : '${_con.donationStore.image}.png',
                                      style: Theme.of(context).textTheme.bodyText2,
                                      maxLines: 1,
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.7))
                                    ),
                                    minWidth: MediaQuery.of(context).size.width / 3,
                                    height: 35,
                                    child: Text(
                                      S.of(context).choose_image,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    color: Theme.of(context).dividerColor.withOpacity(0.7),
                                    onPressed: () {
                                      chooseImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    S.of(context).address,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                )
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 60,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.5)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Theme.of(context).hintColor.withOpacity(0.2),
                                      )
                                    ]
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      _con.insertAddress();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on, color: Theme.of(context).accentColor),
                                        SizedBox(width: 20),
                                        Text(
                                          _con.address.latitude.toString() != '0'
                                              ? '${currentUser.value.city}, ${currentUser.value.street}'
                                              : 'New address',
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ],
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Theme.of(context).accentColor,)
                        ),
                        height: 45,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          S.of(context).submit,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if(_con.donationStore.image != null)
                            _con.insertDonation();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

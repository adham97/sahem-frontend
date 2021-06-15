import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/assistance_request_controller.dart';
import '../elements/CardInfo.dart';
import '../helpers/app_config.dart' as config;
import '../models/card.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;

class AssistanceRequestWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  AssistanceRequestWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AssistanceRequestWidgetState createState() => _AssistanceRequestWidgetState();
}

class _AssistanceRequestWidgetState extends StateMVC<AssistanceRequestWidget> {

  AssistanceRequestController _con;
  _AssistanceRequestWidgetState() : super(AssistanceRequestController()) {
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
      }).whenComplete(() => _con.assistance.userIdPhoto = base64Image);
    });
  }

  void getCardInfo(Cards card) {
    setState(() => _con.card = card);
  }

  void moveToCardInfo() async {
    final information = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => CardInfoWidget()),
    );
    getCardInfo(information);
  }

  @override
  Widget build(BuildContext context) {
    hintText = S.of(context).select;
    return Scaffold(
        key: _con.scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: ValueListenableBuilder(
            valueListenable: settingRepo.setting,
            builder: (context, value, child) {
              return Text(
                S.of(context).assistance_request,
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
                  decoration: settingRepo.setting.value.brightness.value == Brightness.light
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
                        key: _con.platformFormKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    S.of(context).platform_categories,
                                    style: Theme.of(context).textTheme.subtitle1
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 - 60,
                                  height: 40,
                                  padding: settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                      ? EdgeInsets.only(left: 15, right: 10)
                                      : EdgeInsets.only(left: 10, right: 15),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2)),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: new DropdownButton(
                                      value: _con.index,
                                      items: _con.platformCategories.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(
                                              settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                                  ? item.nameEn
                                                  : item.nameAr,
                                              style: Theme.of(context).textTheme.bodyText2
                                          ),
                                          value: item.id,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _con.index = value;
                                          _con.assistance.platformCategoriesId = _con.index;
                                        });
                                      },
                                      isExpanded: true,
                                      hint: Text(
                                          hintText,
                                          style: Theme.of(context).textTheme.bodyText2
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    S.of(context).assistance_name,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                )
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) {
                                if(input.isNotEmpty){
                                  settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                      ? _con.assistance.nameEn = input
                                      : _con.assistance.nameAr = input;
                                }
                              },
                              validator: (input) => input.isEmpty ? S.of(context).it_cannot_be_left_blank : null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                hintText: S.of(context).assistance_name,
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
                                  settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                      ? _con.assistance.descriptionEn = input
                                      : _con.assistance.descriptionAr = input;
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
                                  S.of(context).id_photo,
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
                                      _con.assistance.userIdPhoto == null
                                          ? S.of(context).no_image_chosen
                                          : '${userRepo.currentUser.value.firstName.toLowerCase()}_${userRepo.currentUser.value.lastName.toLowerCase()}.png',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black87,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(text: '${S.of(context).visa_card}', style: Theme.of(context).textTheme.subtitle1),
                                      new TextSpan(text: ' '),
                                      new TextSpan(text: '(${S.of(context).optional})', style: Theme.of(context).textTheme.bodyText2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                  moveToCardInfo();
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle, color: Theme.of(context).accentColor),
                                    SizedBox(width: 20),
                                    Text(
                                      _con.card.cardNumber != null
                                          ? '${_con.card.cardNumber}'
                                          : 'New card',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
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
                                              ? '${userRepo.currentUser.value.city}, ${userRepo.currentUser.value.street}'
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
                          // _con.platformFormKey.currentState.save();
                          // if(_con.assistance.platformCategoriesId != '0' && _con.assistance.userIdPhoto != null) {
                          _con.insertAssistance();
                          // } else {
                          //   _con.scaffoldKey.currentState.showSnackBar(SnackBar(
                          //     content: Text(S.of(context).check_that_the_information_is_entered_correctly),
                          //   ));
                          // }
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

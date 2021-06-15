import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/assistance_response_controller.dart';
import '../models/assistance.dart';
import '../models/user.dart';
import '../models/platform_categories.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/assistance_response_repository.dart';
import '../repository/user_repository.dart';

class AssistanceResponseWidget extends StatefulWidget {
  final Assistance assistance;
  final User user;
  final String platformCategoriesId;
  AssistanceResponseWidget({Key key, this.assistance, this.user, this.platformCategoriesId}): super (key: key);

  @override
  _AssistanceResponseWidgetState createState() => _AssistanceResponseWidgetState();
}

class _AssistanceResponseWidgetState extends StateMVC<AssistanceResponseWidget> {
  AssistanceResponseController _con;
  _AssistanceResponseWidgetState() : super(AssistanceResponseController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.assistance = widget.assistance;
    _con.user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, value, child) {
            return FutureBuilder<PlatformCategories>(
              future: getPlatformCategories(widget.platformCategoriesId),
              builder: (context, snapshot) {
                if(snapshot.data == null) {
                  return Text('');
                } else {
                  return snapshot.hasData
                    ? Text(
                    '${S.of(context).assistance_request} (${snapshot.data.nameEn})',
                    style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
                  )
                    : Text('');
                }
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: (currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                ? EdgeInsets.only(bottom: 30)
                : EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Column(
                  children: [
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      SizedBox(height: 10),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          _con.user.image,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      SizedBox(height: 15),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      Text(
                        '${_con.user.firstName} ${_con.user.fatherName} ${_con.user.grandfatherName} ${_con.user.lastName}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text( settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                  ? _con.assistance.nameEn != null
                                  ? _con.assistance.nameEn
                                  : ''
                                  : _con.assistance.nameAr != null
                                  ? _con.assistance.nameAr
                                  : '',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text( settingRepo.setting.value.mobileLanguage.value == Locale('en', '')
                                    ? _con.assistance.descriptionEn != null
                                    ? _con.assistance.descriptionEn
                                    : ''
                                    : _con.assistance.descriptionAr != null
                                    ? _con.assistance.descriptionAr
                                    : '',
                                  style: Theme.of(context).textTheme.subtitle1,
                                  maxLines: 20,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image.network(
                        _con.assistance.userIdPhoto,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width - 60,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                _con.user.identifyId,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          SizedBox(height:10),
                          Row(
                            children: [
                              Text(
                                _con.user.email,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          SizedBox(height:10),
                          Row(
                            children: [
                              Text(
                                _con.user.phone,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          SizedBox(height:10),
                          Row(
                            children: [
                              Text(
                                '${_con.user.city} - ${_con.user.street}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: ((currentUser.value.userRole == '1' || currentUser.value.userRole == '2') && widget.assistance.acceptanceId == '1')
          ? Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: MaterialButton(
                    onPressed: () {
                      _con.acceptanceId = '3';
                      _con.assistanceResponse();
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Color(0xffce2029),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      S.of(context).refusal,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: MaterialButton(
                    onPressed: () {
                      _con.acceptanceId = '2';
                      _con.assistanceResponse();
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      S.of(context).acceptance,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          : SizedBox(height: 0),
    );
  }
}
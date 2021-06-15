import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/user.dart';
import '../models/platform_categories.dart';
import '../models/platform.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/assistance_response_repository.dart';
import '../repository/user_repository.dart';

class PlatformSupportWidget extends StatefulWidget {
  final Platform platform;
  final User user;
  PlatformSupportWidget({Key key, this.platform, this.user}): super (key: key);

  @override
  _PlatformSupportWidgetState createState() => _PlatformSupportWidgetState();
}

class _PlatformSupportWidgetState extends State<PlatformSupportWidget> {
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
              future: getPlatformCategories(widget.platform.platformCategoriesId),
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
                          widget.user.image,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      SizedBox(height: 15),
                    if(currentUser.value.userRole == '1' || currentUser.value.userRole == '2')
                      Text(
                        '${widget.user.firstName} ${widget.user.lastName}',
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
                                  ? widget.platform.nameEn != null
                                  ? widget.platform.nameEn
                                  : ''
                                  : widget.platform.nameAr != null
                                  ? widget.platform.nameAr
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
                                    ? widget.platform.descriptionEn != null
                                    ? widget.platform.descriptionEn
                                    : ''
                                    : widget.platform.descriptionAr != null
                                    ? widget.platform.descriptionAr
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(
                    //             _con.user.identifyId,
                    //             style: Theme.of(context).textTheme.subtitle2,
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height:10),
                    //       Row(
                    //         children: [
                    //           Text(
                    //             _con.user.email,
                    //             style: Theme.of(context).textTheme.subtitle2,
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height:10),
                    //       Row(
                    //         children: [
                    //           Text(
                    //             _con.user.phone,
                    //             style: Theme.of(context).textTheme.subtitle2,
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(height:10),
                    //       Row(
                    //         children: [
                    //           Text(
                    //             '${_con.user.city} - ${_con.user.street}',
                    //             style: Theme.of(context).textTheme.subtitle2,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
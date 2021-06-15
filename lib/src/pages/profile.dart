import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/ProfileSettingsDialog.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}): super (key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends StateMVC<ProfileWidget> {

  UserController _con;
  _ProfileWidgetState() : super(UserController()) {
    _con = controller;
  }

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
      file.then((value) {
        setState(() {
          tmpFile = value;
          base64Image = base64Encode(value.readAsBytesSync());
        });
      }).whenComplete(() => startUpload());
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    userRepo.uploadUserImage(base64Image).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () {
            userRepo.currentUser.value.userRole == '4'
                ? Navigator.of(context).pushReplacementNamed('/Driver')
                : Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: settingRepo.setting,
          builder: (context, value, child) {
            return Text(
              S.of(context).profile,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      color: Theme.of(context).primaryColor,
                      height: 170,
                      child: new Wrap(
                        children: <Widget>[
                          new Align(
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.horizontal_rule,
                              size: 35,
                              color: Theme.of(context).hintColor.withOpacity(0.7),
                            ),
                          ),
                          new ListTile(
                              leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Icon(
                                    Icons.perm_media_outlined,
                                    color: Theme.of(context).hintColor.withOpacity(0.7),
                                  )
                              ),
                              title: Text(
                                  S.of(context).select_profile_picture,
                                  style: Theme.of(context).textTheme.headline6
                              ),
                              onTap: () => chooseImage()
                          ),
                          SizedBox(height: 10),
                          new ListTile(
                            leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Icon(
                                  Icons.now_wallpaper_outlined,
                                  color: Theme.of(context).hintColor.withOpacity(0.7),
                                )
                            ),
                            title: Text(
                                S.of(context).view_profile_picture,
                                style: Theme.of(context).textTheme.headline6
                            ),
                            onTap: () => Navigator.of(context).pushReplacementNamed('/FullScreen', arguments: userRepo.currentUser.value.image),
                          ),
                        ],
                      ),
                    );
                  }
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  userRepo.currentUser.value.image,
                  fit: BoxFit.cover,
                  height: 170,
                  width: 170,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              '${userRepo.currentUser.value.firstName} ${userRepo.currentUser.value.lastName}',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: settingRepo.setting.value.brightness.value == Brightness.light
                  ? BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: Theme.of(context).hintColor.withOpacity(0.15),
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
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 28,
                    ),
                    minLeadingWidth: 20,
                    title: Text(
                        S.of(context).persona_file,
                        style: Theme.of(context).textTheme.headline6
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: ProfileSettingsDialog(
                        user: userRepo.currentUser.value,
                        onChanged: () {
                          _con.updateUser(user: userRepo.currentUser.value);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).id_number,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: Text(
                      userRepo.currentUser.value.identifyId,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).email,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: Text(
                      userRepo.currentUser.value.email,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).phone,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: Text(
                      userRepo.currentUser.value.phone,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).address,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: Text(
                      '${userRepo.currentUser.value.city} - ${userRepo.currentUser.value.street}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: Theme.of(context).primaryColor,
          height: 170,
          child: new Wrap(
            children: <Widget>[
              new Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.horizontal_rule,
                  size: 35,
                  color: Theme.of(context).hintColor.withOpacity(0.7),
                ),
              ),
              new ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Icon(
                      Icons.perm_media_outlined,
                      color: Theme.of(context).hintColor.withOpacity(0.7),
                    )
                  ),
                  title: Text(
                    S.of(context).select_profile_picture,
                    style: Theme.of(context).textTheme.headline6
                  ),
                  onTap: () => {}
              ),
              SizedBox(height: 10),
              new ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Icon(
                    Icons.now_wallpaper_outlined,
                    color: Theme.of(context).hintColor.withOpacity(0.7),
                  )
                ),
                title: Text(
                    S.of(context).view_profile_picture,
                    style: Theme.of(context).textTheme.headline6
                ),
                onTap: () => {},
              ),
            ],
          ),
        );
      }
  );
}



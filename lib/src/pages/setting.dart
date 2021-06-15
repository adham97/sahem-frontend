import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../elements/ProfileSettingsDialog.dart';

class SettingWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SettingWidget({Key key, this.parentScaffoldKey}): super (key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: brightness,
          builder: (context, value, child) {
            return Text(
              S.of(context).persona_file,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                'assets/img/unknown.png',
                fit: BoxFit.cover,
                height: 130,
                width: 130,
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Text(
                S.of(context).choose_image,
                style: TextStyle(
                    color: Color(0xff247de5),
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    title: Text(
                        S.of(context).profile_settings,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        )
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: ProfileSettingsDialog(
                        //user: currentUser.value,
                        onChanged: () {
                          //_con.update(currentUser.value);
                          //setState(() {});
                        },
                      ),
                    ),

                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).first_name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).father_name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).grandfather_name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).last_name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).id_number,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).birthday,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.name',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).email,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.email',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).phone,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      ' ',//'currentUser.value.phone',
                      style: TextStyle(color: Theme.of(context).focusColor),
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

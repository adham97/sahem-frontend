import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/language.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart';

class LanguagesWidget extends StatefulWidget {
  @override
  _LanguagesWidgetState createState() => _LanguagesWidgetState();
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  LanguagesList languagesList;
  @override
  void initState() {
    languagesList = new LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () {
            currentUser.value.userRole == '4'
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
              S.of(context).languages,
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
            );
          },
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: languagesList.languages.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemBuilder: (context, index) {
          Language _language = languagesList.languages.elementAt(index);
          settingRepo.getDefaultLanguage(
              settingRepo.setting.value.mobileLanguage.value.languageCode).then((_langCode) {
            if (_langCode == _language.code) {
              setState(() {
                _language.selected = true;
              });
            }
          });
          return InkWell(
            onTap: () async {
              settingRepo.setting.value.mobileLanguage.value = new Locale(_language.code, '');
              settingRepo.setting.notifyListeners();
              languagesList.languages.forEach((_l) {
                setState(() {
                  _l.selected = false;
                });
              });
              _language.selected = !_language.selected;
              settingRepo.setDefaultLanguage(_language.code);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.1)),
                color: _language.selected ? Color(0xffe6f2ff) : Theme.of(context).dividerColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Icon(
                      Icons.check,
                      size:  24,
                      color: _language.selected ? Color(0xff247de5) : Colors.grey.shade100,
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    padding: EdgeInsets.only(top: 7),
                    height: 35,
                    child: Text(
                      _language.englishName,
                      style: _language.selected
                      ? TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff247de5),
                      )
                      : Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
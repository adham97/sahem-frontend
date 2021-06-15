import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'route_generator.dart';
import 'src/models/setting.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/repository/settings_repository.dart' as settingRepo;

Future<void> main() async {
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settingRepo.initSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return ValueListenableBuilder(
     valueListenable: settingRepo.setting,
     builder: (context, Setting _setting, _) {
     return  MaterialApp(
       initialRoute: '/Splash',
       onGenerateRoute: RouteGenerator.generateRoute,
       debugShowCheckedModeBanner: false,
       locale: _setting.mobileLanguage.value,
       localizationsDelegates: [
         S.delegate,
         GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate,
       ],
       supportedLocales: S.delegate.supportedLocales,
       theme: _setting.brightness.value == Brightness.light
       ? ThemeData(
         fontFamily: 'ProductSans',
         brightness: Brightness.light,
         primaryColor: Colors.white,
         accentColor: config.Colors().mainColor(1),
         dividerColor: config.Colors().scaffoldColor(1),
         focusColor: config.Colors().accentColor(1),
         hintColor: config.Colors().secondColor(1),
         floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
         textTheme: TextTheme(
           headline1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
           headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
           headline3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, color: config.Colors().mainColor(1)),
           headline4: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(1)),
           headline5: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: config.Colors().mainColor(1)),
           headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
           bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(1)),
           bodyText2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(0.5)),
           subtitle1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(1)),
           subtitle2: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400, color: config.Colors().secondColor(0.5)),
           caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: config.Colors().accentColor(1)),
         ),
       )
       : ThemeData(
         fontFamily: 'ProductSans',
         brightness: Brightness.dark,
         primaryColor: Color(0xff1a1b1d),
         accentColor: config.Colors().mainDarkColor(1),
         dividerColor: config.Colors().scaffoldDarkColor(1),
         hintColor: config.Colors().secondDarkColor(1),
         focusColor: config.Colors().accentDarkColor(0.5),
         textTheme: TextTheme(
           headline1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
           headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
           headline3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().secondDarkColor(1)),
           headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: config.Colors().secondDarkColor(1)),
           headline5: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
           headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
           bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: config.Colors().secondDarkColor(1)),
           bodyText2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: config.Colors().secondDarkColor(0.5)),
           subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: config.Colors().secondDarkColor(1)),
           subtitle2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: config.Colors().secondDarkColor(0.5)),
           caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(0.6)),
         ),
       ),
     );
   });
  }
}

import 'package:flutter/material.dart';

class Setting {
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      mainColor = jsonMap['main_color'] ?? null;
      mainDarkColor = jsonMap['main_dark_color'] ?? '';
      secondColor = jsonMap['second_color'] ?? '';
      secondDarkColor = jsonMap['second_dark_color'] ?? '';
      accentColor = jsonMap['accent_color'] ?? '';
      accentDarkColor = jsonMap['accent_dark_color'] ?? '';
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] ?? '';
      scaffoldColor = jsonMap['scaffold_color'] ?? '';
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['language'] ?? "en", '');
    } catch (e) {
      print(e);
    }
  }
}

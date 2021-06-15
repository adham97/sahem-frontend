class Language {
  String code;
  String englishName;
  bool selected;

  Language(this.code, this.englishName, {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language("en", "English"),
      new Language("ar", "Arabic"),
    ];
  }

  List<Language> get languages => _languages;
}

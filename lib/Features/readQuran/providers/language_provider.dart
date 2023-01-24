import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale("en", "");

  void setLanguae(Locale locale) {
    if (isSupportedLanguage(locale.languageCode)) {
      _currentLocale = locale;
      notifyListeners();
    }
  }

  Locale get getLocale {
    return _currentLocale;
  }
}

bool isSupportedLanguage(String code) {
  switch (code) {
    case "en":
      return true;
    case "ar":
      return true;
    case 'fa':
      return true;
    default:
      return false;
  }
}

import 'package:flutter/material.dart';
import '../fonts/font.dart';

TextTheme getTextTheme(String languageCode) {
  return TextTheme(
    headlineLarge: TextStyle(
        fontSize: 22,
        fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    // quran accessing selection headlines
    headline3: TextStyle(
        fontSize: 13,
        fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
        fontWeight: FontWeight.bold,
        color: Colors.black87),
    //app bar headlines
    headline4: TextStyle(
        fontSize: 13,
        fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    //  quran accessing selection subtitles
    subtitle1: TextStyle(
        fontSize: 10,
        fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
        color: Colors.black54),
    bodyText1: TextStyle(
      fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
      fontSize: 16,
    ),
    headline6: TextStyle(
        fontSize: 16,
        fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
        color: Colors.black87),
    // headlineSmall: TextStyle(
    //     fontSize: 13,
    //     fontFamily: languageCode == "en" ? Fonts.roboto : Fonts.notoSansArabic,
    //     color: Colors.black87),
  );
}

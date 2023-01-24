import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData _theme;
  static TextStyle headline1;
  static TextStyle appBarStyle;
  static TextStyle juzStartFont;
  static TextStyle subtitle1;
  static TextStyle generalHeadline;
  static TextStyle descrirption;
  static TextStyle body1;
  static Color pColor;
  static Color sColor;
  static Color bgColor;

  void init(BuildContext context) {
    _theme = Theme.of(context);
    headline1 = _theme.textTheme.headlineLarge;
    generalHeadline = _theme.textTheme.headline6;
    appBarStyle = _theme.textTheme.headline4;
    // descrirption = _theme.textTheme.headlineSmall;
    juzStartFont = _theme.textTheme.headline3;
    subtitle1 = _theme.textTheme.subtitle1;
    body1 = _theme.textTheme.bodyText1;
    pColor = _theme.primaryColor;
    sColor = _theme.colorScheme.secondary;
    bgColor = _theme.backgroundColor;
  }
}

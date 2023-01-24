import 'package:flutter/material.dart';

import '../fonts/font.dart';

//main color codes #7fd7dc to #3fc3ca
const List<Color> mainGradientColors = [Color(0xFF7fd7dc), Color(0xFF3fc3ca)];

//secondary color codes #7ce5e2 to #bef2f1

const List<Color> secondaryGradientColors = [
  Color(0xFF32647C),
  Color(0xFF488FB1)
];

//my secondary color  Atlantic gull (488FB1)

const Color atlanticGullColor = Color(0xff488fb1);

//text Styles

//! heading 1 english
const TextStyle heading1 = TextStyle(
    fontSize: 22,
    fontFamily: Fonts.roboto,
    fontWeight: FontWeight.bold,
    color: Colors.white);

//! body arabic

const TextStyle bodyArabicNoto =
    TextStyle(fontFamily: Fonts.notoSansArabic, fontSize: 16);

//! body english
const TextStyle bodyEnglish1 =
    TextStyle(fontFamily: Fonts.roboto, fontSize: 16);

// quran text style

const TextStyle quranBodyText =
    TextStyle(fontFamily: Fonts.mequran, color: Colors.black);

// quran page color

const Color quranPageColor = Color(0xFFECECEC);

//basmala

const String basmala = "بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ";

const String bismila = "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ";

//basmala text style

const TextStyle basmalaStyle = TextStyle(
  color: atlanticGullColor,
  fontSize: 30,
  fontFamily: Fonts.islamic,
  fontWeight: FontWeight.bold,
);



const Radius appBarRadius = Radius.elliptical(58, 16);

const ShapeBorder appBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: appBarRadius));

const double kBottomNavigationBarHeight = 56;



//  Text(" \ufd3f  $pageNumber  \ufd3e ",
//       style: quranBodyText.copyWith(fontSize: 22), textAlign: TextAlign.center);






//UthmanicHafs1 quran font 
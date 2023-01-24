import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranlation;
  final int numberOfAyahs;
  final String revelationType;

  Surah(
      {@required this.number,
      @required this.name,
      @required this.englishName,
      @required this.englishNameTranlation,
      @required this.numberOfAyahs,
      this.revelationType});

  @override
  List<Object> get props => [
        number,
        name,
        englishName,
        englishNameTranlation,
        numberOfAyahs,
        revelationType
      ];
}

class SurahFields {
  static const String number = "number";
  static const String name = "name";
  static const String englishName = "englishName";
  static const String englishNameTranlation = "englishNameTranslation";
  static const String numberOfAyahs = "numberOfAyahs";
  static const String revelationType = "revelationType";
}

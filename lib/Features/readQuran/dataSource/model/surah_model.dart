import 'package:flutter/material.dart';
import '../../domain/entity/surah.dart';

class SurahModel extends Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranlation;
  final int numberOfAyahs;
  final String revelationType;

  SurahModel(
      {@required this.number,
      @required this.name,
      @required this.englishName,
      @required this.englishNameTranlation,
      @required this.numberOfAyahs,
      this.revelationType})
      : super(
            number: number,
            name: name,
            englishName: englishName,
            englishNameTranlation: englishNameTranlation,
            numberOfAyahs: numberOfAyahs,
            revelationType: revelationType);

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
        number: json[SurahJsonData.number],
        name: json[SurahJsonData.name],
        englishName: json[SurahJsonData.englishName],
        englishNameTranlation: json[SurahJsonData.englishNameTranlation],
        revelationType: json[SurahJsonData.revelationType],
        numberOfAyahs: json[SurahJsonData.numberOfAyahs]);
  }

  Map<String, dynamic> get toJson {
    return {
      SurahJsonData.number: number,
      SurahJsonData.name: name,
      SurahJsonData.englishName: englishName,
      SurahJsonData.englishNameTranlation: englishNameTranlation,
      SurahJsonData.revelationType: revelationType,
      SurahJsonData.numberOfAyahs: numberOfAyahs,
    };
  }
}

class SurahJsonData {
  static const String number = "number";
  static const String name = "name";
  static const String englishName = "englishName";
  static const String englishNameTranlation = "englishNameTranslation";
  static const String numberOfAyahs = "numberOfAyahs";
  static const String revelationType = "revelationType";
}

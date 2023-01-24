import 'package:flutter/material.dart';
import '../../domain/entity/ayah.dart';

class AyahModel extends Ayah {
  final int number;
  final String text;
  final int surah;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final int sajda;

  AyahModel(
      {@required this.number,
      @required this.text,
      @required this.surah,
      @required this.numberInSurah,
      @required this.juz,
      @required this.manzil,
      @required this.page,
      @required this.ruku,
      @required this.hizbQuarter,
      @required this.sajda})
      : super(
            number: number,
            text: text,
            surah: surah,
            numberInSurah: numberInSurah,
            juz: juz,
            manzil: manzil,
            page: page,
            ruku: ruku,
            hizbQuarter: hizbQuarter,
            sajda: sajda);

  factory AyahModel.fromJson(Map<String, dynamic> json, {int number}) {
    return AyahModel(
        number: json[AyahJson.number],
        text: json[AyahJson.text],
        surah: number != null ? number : json[AyahJson.surah]["number"],
        numberInSurah: json[AyahJson.numberInSurah],
        juz: json[AyahJson.juz],
        manzil: json[AyahJson.manzil],
        page: json[AyahJson.page],
        ruku: json[AyahJson.ruku],
        hizbQuarter: json[AyahJson.hizbQuarter],
        sajda: (json[AyahJson.sajda] == true) ? 1 : 0);
  }

  factory AyahModel.fromDB(Map<String, dynamic> json) {
    return AyahModel(
        number: json[AyahFields.number],
        text: json[AyahFields.text],
        surah: json[AyahFields.surah],
        numberInSurah: json[AyahFields.numberInSurah],
        juz: json[AyahFields.juz],
        manzil: json[AyahFields.manzil],
        page: json[AyahFields.page],
        ruku: json[AyahFields.ruku],
        hizbQuarter: json[AyahFields.hizbQuarter],
        sajda: json[AyahFields.sajda]);
  }

  Map<String, dynamic> get toJson {
    return {
      AyahJson.number: number,
      AyahJson.text: text,
      AyahJson.surah: surah,
      AyahJson.numberInSurah: numberInSurah,
      AyahJson.juz: juz,
      AyahJson.manzil: manzil,
      AyahJson.page: page,
      AyahJson.ruku: ruku,
      AyahJson.hizbQuarter: hizbQuarter,
      AyahJson.sajda: sajda,
    };
  }

  static List<AyahModel> getListOfAyahModel(
      List<dynamic> mapList, int surahNumber) {
    return List<AyahModel>.generate(mapList.length, (index) {
      return AyahModel.fromJson(mapList[index], number: surahNumber);
    });
  }

  int getIntValOfBool(bool val) {
    if (val) {
      return 1;
    }
    return 0;
  }
}

class AyahJson {
  static const String number = "number";
  static const String text = "text";
  static const String surah = "surah";
  static const String numberInSurah = "numberInSurah";
  static const String juz = "juz";
  static const String manzil = "manzil";
  static const String page = "page";
  static const String ruku = "ruku";
  static const String hizbQuarter = "hizbQuarter";
  static const String sajda = "sajda";
}

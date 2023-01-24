import 'package:flutter/material.dart';
import '../entity/kurdish_Translation.dart';

class kurdishTranslationModel extends kurdishTranslation {
  final int ayah;
  final String translationType;
  final String text;
  final int surah;

  kurdishTranslationModel(
      {@required this.ayah,
      @required this.translationType,
      @required this.text,
      @required this.surah})
      : super(
            ayah: ayah,
            text: text,
            translationType: translationType,
            surah: surah);

  factory kurdishTranslationModel.fromJson(
      Map<String, dynamic> json, String translationType) {
    return kurdishTranslationModel(
      ayah: int.parse(json[kurdishTranslationJson.ayah]),
      text: json[kurdishTranslationJson.text],
      translationType: translationType,
      surah: int.parse(json[kurdishTranslationJson.sura]),
    );
  }

  factory kurdishTranslationModel.fromDB(Map<String, dynamic> json) {
    return kurdishTranslationModel(
      ayah: json[kurdishTranslationFields.ayah],
      text: json[kurdishTranslationFields.text],
      surah: json[kurdishTranslationFields.surah],
      translationType: json[kurdishTranslationFields.translationType],
    );
  }

  Map<String, dynamic> get toDB {
    return {
      kurdishTranslationFields.ayah: ayah,
      kurdishTranslationFields.text: text,
      kurdishTranslationFields.translationType: translationType,
      kurdishTranslationFields.surah: surah
    };
  }

  static List<kurdishTranslationModel> getListOfAyahModel(
      List<dynamic> jsonlist) {
    return List<kurdishTranslationModel>.generate(jsonlist.length, (index) {
      return kurdishTranslationModel.fromJson(
          jsonlist[index], "${KurdishTafseerType.TafseeriAsyan}");
    });
  }
}

class kurdishTranslationJson {
  static const String ayah = "id";
  static const String text = "translation";
  static const String sura = "sura";
}

enum KurdishTafseerType { TafseeriAsyan }

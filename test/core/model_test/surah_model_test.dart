import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/surah.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';

import '../../fixture/fixture_reader.dart';

void main() {
  group("SurahModel", () {
    final surahModel = SurahModel(
        number: 114,
        name: "سُورَةُ النَّاسِ",
        englishName: "An-Naas",
        englishNameTranlation: "Mankind",
        revelationType: "Meccan",
        numberOfAyahs: 6);

    test("SurahModel is Subtype of Surah ", () {
      expect(surahModel, isA<Surah>());
    });

    test("make SurahModel from json file ", () {
      final jsonData = jsonDecode(fixture("json_surah.json"));
      final jsonSurahModel=SurahModel.fromJson(jsonData);
      expect(jsonSurahModel, equals(surahModel));
    });
    test("to json", () {
      final jsonData=jsonDecode(fixture("json_surah.json"));
      final toJsonMap=jsonEncode(surahModel.toJson);
      expect(toJsonMap, jsonEncode(jsonData));

    });
  });
}

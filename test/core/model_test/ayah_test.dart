import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/ayah.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';

import '../../fixture/fixture_reader.dart';

void main() {
  group("AyahModel", () {
    final ayahModel = AyahModel(
        number: 6236,
        text: "مِنَ الْجِنَّةِ وَالنَّاسِ",
        surah: 114,
        numberInSurah: 6,
        juz: 30,
        manzil: 7,
        page: 604,
        ruku: 556,
        hizbQuarter: 240,
        sajda: 0);

    final ayah1 = AyahModel(
        number: 6231,
        text:
            "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ قُلْ أَعُوذُ بِرَبِّ النَّاسِ",
        surah: 114,
        numberInSurah: 1,
        juz: 30,
        manzil: 7,
        page: 604,
        ruku: 556,
        hizbQuarter: 240,
        sajda: 0);
    final ayah2 = AyahModel(
        number: 6232,
        text: "مَلِكِ النَّاسِ",
        surah: 114,
        numberInSurah: 2,
        juz: 30,
        manzil: 7,
        page: 604,
        ruku: 556,
        hizbQuarter: 240,
        sajda: 0);
    final expectedList = [ayah1, ayah2];

    test("AyahModel is subtype of Ayah", () {
      expect(ayahModel, isA<Ayah>());
    });

    test("build AyahModel from json", () {
      final jsonMap = jsonDecode(fixture("ayahData.json"));
      final ayahJson = AyahModel.fromJson(jsonMap);
      expect(ayahJson, equals(ayahModel));
    });

    test("convert AyahModel to json", () {
      final jsonMap = jsonDecode(fixture("ayahData.json"));
      final ayahtoJson = jsonEncode(ayahModel.toJson);
      expect(ayahtoJson, jsonEncode(jsonMap));
    });

    test("should return List of AyahModel from json file", () {
           int surahNumber=114;
      final jsonMap = jsonDecode(fixture("list_ayahModel.json"));
      final List<AyahModel> list = AyahModel.getListOfAyahModel(jsonMap,surahNumber);
    
      expect(list, expectedList);
    });
  });
}

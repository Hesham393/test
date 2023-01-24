import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/data/localDataSource.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/core/error/error.dart';
import 'package:quran_twekl_app/core/sqflite_database/db_helper.dart';
import '../../../../fixture/fixture_reader.dart';
import 'localDataSource_test.mocks.dart';

@GenerateMocks([DBhelper])
void main() {
  LocalDataSourceImp localDataSourceImp;
  DBhelper mockDBhelper;
  setUpAll(() {
    mockDBhelper = MockDBhelper();
    localDataSourceImp = LocalDataSourceImp(dBhelper: mockDBhelper);
  });

  group("getListOfAyahOfPage", () {
    const pageNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final ayahList = AyahModel.getListOfAyahModel(jsonList, 1);
    test("should return ayahs of page", () async {
      when(mockDBhelper.getAyahsOfPage(pageNumber))
          .thenAnswer((_) async => ayahList);

      final result = await localDataSourceImp.getListOfAyahOfPage(pageNumber);
      verify(mockDBhelper.getAyahsOfPage(pageNumber));
      expect(result, equals(ayahList));
    });

    test("should throw exception when call to getlistofAyahsOfPage", () async {
      when(mockDBhelper.getAyahsOfPage(pageNumber))
          .thenThrow(DatabaseException());

      final result = localDataSourceImp.getListOfAyahOfPage;
      expect(() => result(pageNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group("getListOfAyahOfSurah", () {
    const surahNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final ayahList = AyahModel.getListOfAyahModel(jsonList, 1);
    test("should return ayahs of surah", () async {
      when(mockDBhelper.getAyahsOfSurah(surahNumber))
          .thenAnswer((_) async => ayahList);

      final result = await localDataSourceImp.getListAyahsOfSurah(surahNumber);
      verify(mockDBhelper.getAyahsOfSurah(surahNumber));
      expect(result, equals(ayahList));
    });

    test("should throw exception when call to getlistofAyahsOfPage", () async {
      when(mockDBhelper.getAyahsOfSurah(surahNumber))
          .thenThrow(DatabaseException());

      final result = localDataSourceImp.getListAyahsOfSurah;
      expect(() => result(surahNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group("getFirstNumberPageOfSurah", () {
    const surahNumber = 50;
    const pageNumber = 518;
    test("should return first page of surah", () async {
      when(mockDBhelper.getFirstNumberPageOfSurah(surahNumber))
          .thenAnswer((_) async => pageNumber);

      final result =
          await localDataSourceImp.getFirstNumberPageOfSurah(surahNumber);
      verify(mockDBhelper.getFirstNumberPageOfSurah(surahNumber));
      expect(result, equals(pageNumber));
    });

    test("should throw exception when call to getlistofAyahsOfPage", () async {
      when(mockDBhelper.getFirstNumberPageOfSurah(surahNumber))
          .thenThrow(DatabaseException());

      final result = localDataSourceImp.getFirstNumberPageOfSurah;
      expect(() => result(surahNumber), throwsA(isA<DatabaseException>()));
    });
  });

  group("getCountVersesOfSurah", () {
    const surahNumber = 1;
    const countVerses = 7;
    test("should return count verses of surah", () async {
      when(mockDBhelper.getCountVersesOfSurah(surahNumber))
          .thenAnswer((_) async => countVerses);

      final result =
          await localDataSourceImp.getCountVersesOfSurah(surahNumber);
      verify(mockDBhelper.getCountVersesOfSurah(surahNumber));
      expect(result, equals(countVerses));
    });

    test("should throw exception when call to getCountVersesOfSurah", () async {
      when(mockDBhelper.getCountVersesOfSurah(surahNumber))
          .thenThrow(DatabaseException());

      final result = localDataSourceImp.getCountVersesOfSurah;
      expect(() => result(surahNumber), throwsA(isA<DatabaseException>()));
    });
  });

  //getCountVersesOfPage
  group("getCountVersesOfPage", () {
    const pageNumber = 1;
    const countVerses = 7;
    test("should return count verses of page", () async {
      when(mockDBhelper.getCountVersesOfPage(pageNumber))
          .thenAnswer((_) async => countVerses);

      final result = await localDataSourceImp.getCountVersesOfPage(pageNumber);
      verify(mockDBhelper.getCountVersesOfPage(pageNumber));
      expect(result, equals(countVerses));
    });

    test("should throw exception when call to getCountVersesOfSurah", () async {
      when(mockDBhelper.getCountVersesOfPage(pageNumber))
          .thenThrow(DatabaseException());

      final result = localDataSourceImp.getCountVersesOfPage;
      expect(() => result(pageNumber), throwsA(isA<DatabaseException>()));
    });
  });

  //getAllSurah
  group("getAllSurah", () {
    final jsonList = jsonDecode(fixture("surahList.json"));
    final list = List<SurahModel>.generate(
        jsonList.length, ((index) => SurahModel.fromJson(jsonList[index])));
    test("should return get all Surah", () async {
      when(mockDBhelper.getAllSurah()).thenAnswer((_) async => list);

      final result = await localDataSourceImp.getAllSurah();
      verify(mockDBhelper.getAllSurah());
      expect(result, equals(list));
    });

    test("should throw exception when call to getAllSurah", () async {
      when(mockDBhelper.getAllSurah()).thenThrow(DatabaseException());

      final result = localDataSourceImp.getAllSurah;
      expect(() => result(), throwsA(isA<DatabaseException>()));
    });
  });

  group("getAllAyah", () {
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final list = List<AyahModel>.generate(
        jsonList.length, ((index) => AyahModel.fromJson(jsonList[index])));
    test("should return get all Ayah", () async {
      when(mockDBhelper.getAllAyah()).thenAnswer((_) async => list);

      final result = await localDataSourceImp.getAllAyah();
      verify(mockDBhelper.getAllAyah());
      expect(result, equals(list));
    });

    test("should throw exception when call to getAllAyah", () async {
      when(mockDBhelper.getAllAyah()).thenThrow(DatabaseException());

      final result = localDataSourceImp.getAllAyah;
      expect(() => result(), throwsA(isA<DatabaseException>()));
    });
  });
}

import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/data/localDataSource.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/repository/readQuranRepositoryImp.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/ayah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getCountVersesOfSurah.dart';
import 'package:quran_twekl_app/core/error/error.dart';
import 'package:quran_twekl_app/core/failure/failure.dart';

import '../../../../fixture/fixture_reader.dart';
import 'readQuranRepositoryImp_test.mocks.dart';

@GenerateMocks([LocalDataSource])
void main() {
  LocalDataSource mockLocalDataSource;
  ReadQuranRepositoryImp readQuranRepositoryImp;

  setUpAll(() {
    mockLocalDataSource = MockLocalDataSource();
    readQuranRepositoryImp = ReadQuranRepositoryImp(mockLocalDataSource);
  });

  group("getListOfAyahOfPage", () {
    const pageNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final listAyah = AyahModel.getListOfAyahModel(jsonList, 1);

    test("should return ayahs of page ", () async {
      when(mockLocalDataSource.getListOfAyahOfPage(pageNumber))
          .thenAnswer((_) async => listAyah);

      final result =
          await readQuranRepositoryImp.getListOfAyahOfPage(pageNumber);
      verify(mockLocalDataSource.getListOfAyahOfPage(pageNumber));
      expect(result, equals(Right(listAyah)));
    });
    test("should return databaseFailure ", () async {
      when(mockLocalDataSource.getListOfAyahOfPage(pageNumber))
          .thenThrow(DatabaseException());

      final result =
          await readQuranRepositoryImp.getListOfAyahOfPage(pageNumber);
      verify(mockLocalDataSource.getListOfAyahOfPage(pageNumber));
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getListAyahsOfSurah", () {
    const surahNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final listAyah = AyahModel.getListOfAyahModel(jsonList, 1);

    test("should return ayahs of surah ", () async {
      when(mockLocalDataSource.getListAyahsOfSurah(surahNumber))
          .thenAnswer((_) async => listAyah);

      final result =
          await readQuranRepositoryImp.getListAyahsOfSurah(surahNumber);
      verify(mockLocalDataSource.getListAyahsOfSurah(surahNumber));
      expect(result, equals(Right(listAyah)));
    });
    test("should return databaseFailure ", () async {
      when(mockLocalDataSource.getListAyahsOfSurah(surahNumber))
          .thenThrow(DatabaseException());

      final result =
          await readQuranRepositoryImp.getListAyahsOfSurah(surahNumber);
      verify(mockLocalDataSource.getListAyahsOfSurah(surahNumber));
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getFirstNumberPageOfSurah", () {
    const surahNumber = 1;
    const firstPageNumber = 1;
    test("should return first page number of surah", () async {
      when(mockLocalDataSource.getFirstNumberPageOfSurah(surahNumber))
          .thenAnswer((_) async => firstPageNumber);

      final result =
          await readQuranRepositoryImp.getFirstNumberPageOfSurah(surahNumber);

      verify(mockLocalDataSource.getFirstNumberPageOfSurah(surahNumber));
      expect(result, Right(firstPageNumber));
    });

    test("should return database failure", () async {
      when(mockLocalDataSource.getFirstNumberPageOfSurah(surahNumber))
          .thenThrow(DatabaseException());
      final result =
          await readQuranRepositoryImp.getFirstNumberPageOfSurah(surahNumber);
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getCountVersesOfSurah", () {
    const surahNumber = 1;
    const countVerse = 7;
    test("should return count verses of surah", () async {
      when(mockLocalDataSource.getCountVersesOfSurah(surahNumber))
          .thenAnswer((_) async => countVerse);

      final result =
          await readQuranRepositoryImp.getCountVersesOfSurah(surahNumber);

      verify(mockLocalDataSource.getCountVersesOfSurah(surahNumber));
      expect(result, Right(countVerse));
    });

    test("should return database failure", () async {
      when(mockLocalDataSource.getCountVersesOfSurah(surahNumber))
          .thenThrow(DatabaseException());
      final result =
          await readQuranRepositoryImp.getCountVersesOfSurah(surahNumber);
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getCountVersesOfPage", () {
    const pageNumber = 1;
    const countVerse = 7;
    test("should return count verses of Page", () async {
      when(mockLocalDataSource.getCountVersesOfPage(pageNumber))
          .thenAnswer((_) async => countVerse);

      final result =
          await readQuranRepositoryImp.getCountVersesOfPage(pageNumber);

      verify(mockLocalDataSource.getCountVersesOfPage(pageNumber));
      expect(result, Right(countVerse));
    });

    test("should return database failure", () async {
      when(mockLocalDataSource.getCountVersesOfPage(pageNumber))
          .thenThrow(DatabaseException());
      final result =
          await readQuranRepositoryImp.getCountVersesOfPage(pageNumber);
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getAllSurah", () {
    final List<dynamic> jsonList = jsonDecode(fixture("surahList.json"));
    final listSurah = List<SurahModel>.generate(
        jsonList.length, ((index) => SurahModel.fromJson(jsonList[index])));
    test("should return all surah ", () async {
      when(mockLocalDataSource.getAllSurah())
          .thenAnswer((_) async => listSurah);

      final result = await readQuranRepositoryImp.getAllSurah();

      verify(mockLocalDataSource.getAllSurah());
      expect(result, Right(listSurah));
    });

    test("should return database failure", () async {
      when(mockLocalDataSource.getAllSurah()).thenThrow(DatabaseException());
      final result = await readQuranRepositoryImp.getAllSurah();
      expect(result, Left(DatabaseFailure()));
    });
  });

  group("getAllAyah", () {
    final List<dynamic> jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final listAyah = List<AyahModel>.generate(
        jsonList.length, ((index) => AyahModel.fromJson(jsonList[index])));
    test("should return all ayah ", () async {
      when(mockLocalDataSource.getAllAyah()).thenAnswer((_) async => listAyah);

      final result = await readQuranRepositoryImp.getAllAyah();

      verify(mockLocalDataSource.getAllAyah());
      expect(result, Right(listAyah));
    });

    test("should return database failure", () async {
      when(mockLocalDataSource.getAllAyah()).thenThrow(DatabaseException());
      final result = await readQuranRepositoryImp.getAllAyah();
      expect(result, Left(DatabaseFailure()));
    });
  });
}

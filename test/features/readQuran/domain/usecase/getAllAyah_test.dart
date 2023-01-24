import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/ayah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getAllAyah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getAllSurah.dart';
import '../../../../fixture/fixture_reader.dart';

import 'getListAyahsOfSurah_test.mocks.dart';

void main() {
  GetAllAyah usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetAllAyah(repository: mockReadQuranRepository);
  });

  group("getAllAyah", () {
    final List<dynamic> jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final List<Ayah> ayahList = List<Ayah>.generate(
        jsonList.length, (index) => AyahModel.fromJson(jsonList[index]));
    test("should return all surah ", () async {
      when(mockReadQuranRepository.getAllAyah())
          .thenAnswer((_) async => Right(ayahList));

      final result = await usecase.call(NoParam());
      expect(result, equals(Right(ayahList)));
      verify(mockReadQuranRepository.getAllAyah());
    });
  });
}

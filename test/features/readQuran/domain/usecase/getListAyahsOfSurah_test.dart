import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/GetListAyahsOfSurah.dart';

import '../../../../fixture/fixture_reader.dart';

import 'getListAyahsOfSurah_test.mocks.dart';

@GenerateMocks([ReadQuranRepository])
void main() {
  GetListAyahsOfSurah usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetListAyahsOfSurah(mockReadQuranRepository);
  });

  group("getListAyahsOfSurah", () {
    final List<dynamic> jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final ListAyah = AyahModel.getListOfAyahModel(jsonList, 114);
    const surahNumber = 114;
    test("should return List of Ayah ", () async {
      when(mockReadQuranRepository.getListAyahsOfSurah(surahNumber))
          .thenAnswer((_) async => Right(ListAyah));

      final result = await usecase.call(SurahParam(surahNumber));
      verify(mockReadQuranRepository.getListAyahsOfSurah(surahNumber));
      expect(result, Right(ListAyah));
    });
  });
}

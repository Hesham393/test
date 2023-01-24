import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/surah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getAllSurah.dart';
import '../../../../fixture/fixture_reader.dart';
import 'getListAyahsOfSurah_test.mocks.dart';

void main() {
  GetAllSurah usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetAllSurah(mockReadQuranRepository);
  });

  group("getAllSurah", () {
    final jsonList = jsonDecode(fixture("surahList.json"));
    final List<Surah> surahList = List<SurahModel>.generate(
        2, (index) => SurahModel.fromJson(jsonList[index]));
    test("should return all surah ", () async {
      when(mockReadQuranRepository.getAllSurah())
          .thenAnswer((_) async => Right(surahList));

      final result = await usecase.call(NoParam());
      expect(result, equals(Right(surahList)));
      verify(mockReadQuranRepository.getAllSurah());
    });
  });
}

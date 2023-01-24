import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/GetListAyahsOfSurah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getCountVersesOfSurah.dart';
import 'getListAyahsOfSurah_test.mocks.dart';

void main() {
  GetCountVersesOfSurah usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetCountVersesOfSurah(mockReadQuranRepository);
  });

  group("getCountVersesOfSurah", () {
    const countVerse = 7;
    const surahNumber = 1;
    test("should return ayah number of surah ", () async {
      when(mockReadQuranRepository.getCountVersesOfSurah(surahNumber))
          .thenAnswer((_) async => Right(countVerse));

      final result = await usecase.call(SurahParam(surahNumber));
      expect(result, equals(Right(countVerse)));
      verify(mockReadQuranRepository.getCountVersesOfSurah(surahNumber));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/GetListAyahsOfSurah.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getFirstNumberPageOfSurah.dart';

import 'GetListAyahsOfPage_test.mocks.dart';

void main() {
  GetFirstNumberPageOfSurah usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetFirstNumberPageOfSurah(mockReadQuranRepository);
  });

  group("getFirstNumberPageOfSurah", () {
    const pageNumber = 604;
    const surahNumber = 114;
    test("should return first page of surah ", () async {
      when(mockReadQuranRepository.getFirstNumberPageOfSurah(surahNumber))
          .thenAnswer((_) async => Right(pageNumber));

      final result = await usecase.call(SurahParam(surahNumber));
      expect(result, equals(Right(pageNumber)));
      verify(mockReadQuranRepository.getFirstNumberPageOfSurah(surahNumber));
    });
  });
}

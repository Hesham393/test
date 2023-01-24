import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/getCoutVersesOfPage.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/get_list_ayah__page.dart';
import 'getListAyahsOfSurah_test.mocks.dart';

void main() {
  GetCountVersesOfPage usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetCountVersesOfPage(mockReadQuranRepository);
  });

  group("getCountVersesOfPage", () {
    const countVerse = 7;
    const pageNumber = 1;
    test("should return count verses of page ", () async {
      when(mockReadQuranRepository.getCountVersesOfPage(pageNumber))
          .thenAnswer((_) async => Right(countVerse));

      final result = await usecase.call(PageNumberParam(pageNumber));
      expect(result, equals(Right(countVerse)));
      verify(mockReadQuranRepository..getCountVersesOfPage(pageNumber));
    });
  });
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/repository/readQuranRepository.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/get_list_ayah__page.dart';

import '../../../../fixture/fixture_reader.dart';
import 'GetListAyahsOfPage_test.mocks.dart';

@GenerateMocks([ReadQuranRepository])
void main() {
  GetAyahsOfPage usecase;
  ReadQuranRepository mockReadQuranRepository;

  setUpAll(() {
    mockReadQuranRepository = MockReadQuranRepository();
    usecase = GetAyahsOfPage(mockReadQuranRepository);
  });

  group("getListAyahsOfpage", () {
    final List<dynamic> jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final ListAyah = AyahModel.getListOfAyahModel(jsonList, 114);
    const pageNumber = 604;
    test("should return List of Ayah ", () async {
      when(mockReadQuranRepository.getListOfAyahOfPage(pageNumber))
          .thenAnswer((_) async => Right(ListAyah));

      final result = await usecase.call(PageNumberParam(pageNumber));
      expect(result, equals(Right(ListAyah)));
      verify(mockReadQuranRepository.getListOfAyahOfPage(pageNumber));
      verifyNoMoreInteractions(mockReadQuranRepository);
    });
  });
}

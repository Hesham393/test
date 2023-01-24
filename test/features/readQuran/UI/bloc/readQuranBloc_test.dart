import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/bloc/bloc.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/usecase/usecase.dart';
import 'package:quran_twekl_app/core/failure/failure.dart';

import '../../../../fixture/fixture_reader.dart';
import 'readQuranBloc_test.mocks.dart';

@GenerateMocks([
  GetAllSurah,
  GetListAyahsOfSurah,
  GetAyahsOfPage,
  GetCountVersesOfPage,
  GetCountVersesOfSurah,
  GetFirstNumberPageOfSurah,
  GetAllAyah
])
void main() {
  ReadQuranBloc readQuranBloc;
  GetAllSurah getAllSurah;
  GetListAyahsOfSurah getListAyahsOfSurah;
  GetAyahsOfPage getAyahsOfPage;
  GetCountVersesOfPage getCountVersesOfPage;
  GetCountVersesOfSurah getCountVersesOfSurah;
  GetFirstNumberPageOfSurah getFirstNumberPageOfSurah;
  GetAllAyah getAllAyah;

  setUpAll(() {
    getAllSurah = MockGetAllSurah();
    getListAyahsOfSurah = MockGetListAyahsOfSurah();
    getAyahsOfPage = MockGetAyahsOfPage();
    getCountVersesOfPage = MockGetCountVersesOfPage();
    getCountVersesOfSurah = MockGetCountVersesOfSurah();
    getFirstNumberPageOfSurah = MockGetFirstNumberPageOfSurah();
    getAllAyah = MockGetAllAyah();

    readQuranBloc = ReadQuranBloc(
        getAllSurah: getAllSurah,
        getAyahsOfPage: getAyahsOfPage,
        getListAyahsOfSurah: getListAyahsOfSurah,
        firstNumberPageOfSurah: getFirstNumberPageOfSurah,
        getCountVersesOfPage: getCountVersesOfPage,
        getAllAyah: getAllAyah,
        getCountVersesOfSurah: getCountVersesOfSurah);
  });

  group("getAyahsOfPageState", () {
    const pageNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final list = AyahModel.getListOfAyahModel(jsonList, 1);
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getAyahsOfPage.call(PageNumberParam(pageNumber)))
          .thenAnswer((_) async => Right(list)),
      act: ((bloc) => bloc.add(AyahsOfPageEvent(pageNumber: pageNumber))),
      verify: (bloc) => getAyahsOfPage.call(PageNumberParam(pageNumber)),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.versesOfPage),
        AyahsOfPageState(ayahs: list)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getAyahsOfPage.call(PageNumberParam(pageNumber)))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) => bloc.add(AyahsOfPageEvent(pageNumber: pageNumber))),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.versesOfPage),
        equals(ReadQuranErrorState(errorStates: ErrorStates.versesOfPage))
      ],
    );
  });

  group("getAyahsOfSurahState", () {
    const surahNumber = 1;
    final jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final list = AyahModel.getListOfAyahModel(jsonList, 1);
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getListAyahsOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Right(list)),
      act: ((bloc) => bloc.add(AyahsOfSurahEvent(surahNumber: surahNumber))),
      verify: (bloc) => getListAyahsOfSurah.call(SurahParam(surahNumber)),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.versesOfSurah),
        AyahsOfSurahState(ayahs: list)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getListAyahsOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) => bloc.add(AyahsOfSurahEvent(surahNumber: surahNumber))),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.versesOfSurah),
        equals(ReadQuranErrorState(errorStates: ErrorStates.versesOfSurah))
      ],
    );
  });

  group("getFirstNumberPageOfSurah", () {
    const surahNumber = 1;
    const firstPage = 1;
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getFirstNumberPageOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Right(firstPage)),
      act: ((bloc) =>
          bloc.add(FirstPageOfSurahEvent(surahNumber: surahNumber))),
      verify: (bloc) => getFirstNumberPageOfSurah.call(SurahParam(surahNumber)),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.firstPageOfSurah),
        FirstPageOfSurahState(page: firstPage)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getFirstNumberPageOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) =>
          bloc.add(FirstPageOfSurahEvent(surahNumber: surahNumber))),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.firstPageOfSurah),
        equals(ReadQuranErrorState(errorStates: ErrorStates.firstPageOfSurah))
      ],
    );
  });

  group("getCountVersesOfSurah", () {
    const surahNumber = 1;
    const countVerses = 7;
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getCountVersesOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Right(countVerses)),
      act: ((bloc) =>
          bloc.add(CountVersesOfSurahEvent(surahNumber: surahNumber))),
      verify: (bloc) => getCountVersesOfSurah.call(SurahParam(surahNumber)),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.countSurah),
        CountVersesOfSurahState(count: countVerses)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getCountVersesOfSurah.call(SurahParam(surahNumber)))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) =>
          bloc.add(CountVersesOfSurahEvent(surahNumber: surahNumber))),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.countSurah),
        equals(ReadQuranErrorState(errorStates: ErrorStates.countSurah))
      ],
    );
  });

  group("getCountVersesOfPage", () {
    const pageNumber = 1;
    const countVerses = 7;
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getCountVersesOfPage.call(PageNumberParam(pageNumber)))
          .thenAnswer((_) async => Right(countVerses)),
      act: ((bloc) => bloc.add(CountVersesOfPageEvent(pageNumber: pageNumber))),
      verify: (bloc) => getCountVersesOfPage.call(PageNumberParam(pageNumber)),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.countPage),
        CountVersesOfPageState(count: countVerses)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getCountVersesOfPage.call(PageNumberParam(pageNumber)))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) => bloc.add(CountVersesOfPageEvent(pageNumber: pageNumber))),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.countPage),
        equals(ReadQuranErrorState(errorStates: ErrorStates.countPage))
      ],
    );
  });

  group("getAllSurah", () {
    const surahNumber = 1;
    final List<dynamic> jsonList = jsonDecode(fixture("surahList.json"));
    final list = List<SurahModel>.generate(jsonList.length, (index) {
      return SurahModel.fromJson(jsonList[index]);
    });
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () => when(getAllSurah.call(NoParam()))
          .thenAnswer((_) async => Right(list)),
      act: ((bloc) => bloc.add(AllSurahEvent())),
      verify: (bloc) => getAllSurah.call(NoParam()),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.allSurah),
        AllSurahState(allSurah: list)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getAllSurah.call(NoParam()))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) => bloc.add(AllSurahEvent())),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.allSurah),
        equals(ReadQuranErrorState(errorStates: ErrorStates.allSurah))
      ],
    );
  });

  group("getAllAyah", () {
    final List<dynamic> jsonList = jsonDecode(fixture("list_ayahModel.json"));
    final list = List<AyahModel>.generate(jsonList.length, (index) {
      return AyahModel.fromJson(jsonList[index]);
    });
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,success]",
      build: () => readQuranBloc,
      setUp: () =>
          when(getAllAyah.call(NoParam())).thenAnswer((_) async => Right(list)),
      act: ((bloc) => bloc.add(AllAyahEvent())),
      verify: (bloc) => getAllAyah.call(NoParam()),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.allAyah),
        AllAyahState(allAyah: list)
      ],
    );
    blocTest<ReadQuranBloc, ReadQuranState>(
      "should emit [loading,error state]",
      build: () => readQuranBloc,
      setUp: () => when(getAllAyah.call(NoParam()))
          .thenAnswer((_) async => Left(DatabaseFailure())),
      act: ((bloc) => bloc.add(AllAyahEvent())),
      expect: () => [
        ReadQuranLoadingState(loadingStates: LoadingStates.allAyah),
        equals(ReadQuranErrorState(errorStates: ErrorStates.allAyah))
      ],
    );
  });
}

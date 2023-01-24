import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'readQuranState.dart';
import '../../../../core/failure/failure.dart';
import "../../domain/usecase/usecase.dart";

import 'Read_Quran_event.dart';

class ReadQuranBloc extends Bloc<ReadQuranEvent, ReadQuranState> {
  final GetListAyahsOfSurah getListAyahsOfSurah;
  final GetAyahsOfPage getAyahsOfPage;
  final GetAllSurah getAllSurah;
  final GetFirstNumberPageOfSurah firstNumberPageOfSurah;
  final GetCountVersesOfPage getCountVersesOfPage;
  final GetCountVersesOfSurah getCountVersesOfSurah;
  final GetAllAyah getAllAyah;

  ReadQuranBloc(
      {@required this.getAllSurah,
      @required this.getAyahsOfPage,
      @required this.getListAyahsOfSurah,
      @required this.firstNumberPageOfSurah,
      @required this.getCountVersesOfPage,
      @required this.getCountVersesOfSurah,
      @required this.getAllAyah})
      : super(EmptyState()) {
    on<AyahsOfPageEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.versesOfPage));
      final result =
          await getAyahsOfPage.call(PageNumberParam(event.pageNumber));
      result.fold(
          (failure) =>
              emit(ReadQuranErrorState(errorStates: ErrorStates.versesOfPage)),
          (listAyah) {
        emit(AyahsOfPageState(ayahs: listAyah));
      });
    });

    on<AyahsOfSurahEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.versesOfSurah));
      final result =
          await getListAyahsOfSurah.call(SurahParam(event.surahNumber));
      result.fold(
          (failure) =>
              emit(ReadQuranErrorState(errorStates: ErrorStates.versesOfSurah)),
          (listAyah) => emit(AyahsOfSurahState(ayahs: listAyah)));
    });

    on<FirstPageOfSurahEvent>((event, emit) async {
      emit(
          ReadQuranLoadingState(loadingStates: LoadingStates.firstPageOfSurah));

      final result =
          await firstNumberPageOfSurah.call(SurahParam(event.surahNumber));
      result.fold(
          (fail) => emit(
              ReadQuranErrorState(errorStates: ErrorStates.firstPageOfSurah)),
          (page) => emit(FirstPageOfSurahState(page: page)));
    });

    on<CountVersesOfSurahEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.countSurah));
      final result =
          await getCountVersesOfSurah.call(SurahParam(event.surahNumber));
      result.fold(
          (fail) =>
              emit(ReadQuranErrorState(errorStates: ErrorStates.countSurah)),
          (countSurah) => emit(CountVersesOfSurahState(count: countSurah)));
    });

    on<CountVersesOfPageEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.countPage));
      final result =
          await getCountVersesOfPage.call(PageNumberParam(event.pageNumber));
      result.fold(
          (fail) =>
              emit(ReadQuranErrorState(errorStates: ErrorStates.countPage)),
          (countPage) => emit(CountVersesOfPageState(count: countPage)));
    });

    on<AllSurahEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.allSurah));
      final result = await getAllSurah.call(NoParam());
      result.fold(
          (fail) =>
              emit(ReadQuranErrorState(errorStates: ErrorStates.allSurah)),
          (allSurah) => emit(AllSurahState(allSurah: allSurah)));
    });

    on<AllAyahEvent>((event, emit) async {
      emit(ReadQuranLoadingState(loadingStates: LoadingStates.allAyah));

      final result = await getAllAyah.call(NoParam());
      result.fold(
          (fail) => emit(ReadQuranErrorState(errorStates: ErrorStates.allAyah)),
          (allAyah) => emit(AllAyahState(allAyah: allAyah)));
    });
  }

  
}

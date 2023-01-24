import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entity/ayah.dart';
import '../../domain/entity/surah.dart';

abstract class ReadQuranState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

//empty state
class EmptyState extends ReadQuranState {}

//loading state
class ReadQuranLoadingState extends ReadQuranState implements Equatable {
  final LoadingStates loadingStates;

  ReadQuranLoadingState({@required this.loadingStates});

  @override
  // TODO: implement props
  List<Object> get props => [loadingStates];
}

//error state
class ReadQuranErrorState extends ReadQuranState implements Equatable {
  final ErrorStates errorStates;
  ReadQuranErrorState({@required this.errorStates});

  @override
  // TODO: implement props
  List<Object> get props => [errorStates];
}

// getAyahsOfPage
class AyahsOfPageState extends ReadQuranState {
  final List<Ayah> ayahs;

  AyahsOfPageState({@required this.ayahs});
}

// getAyahsOfSurah

class AyahsOfSurahState extends ReadQuranState {
  final List<Ayah> ayahs;

  AyahsOfSurahState({@required this.ayahs});
}

//getFirstPageOfSurah

class FirstPageOfSurahState extends ReadQuranState {
  final int page;

  FirstPageOfSurahState({@required this.page});
}

//getCountVersesOfSurah

class CountVersesOfSurahState extends ReadQuranState {
  final int count;

  CountVersesOfSurahState({@required this.count});
}

//getCountVersesOfPage

class CountVersesOfPageState extends ReadQuranState {
  final int count;

  CountVersesOfPageState({@required this.count});
}

//get All Surah

class AllSurahState extends ReadQuranState {
  final List<Surah> allSurah;

  AllSurahState({@required this.allSurah});
}

class AllAyahState extends ReadQuranState {
  final List<Ayah> allAyah;
  AllAyahState({@required this.allAyah});
}

enum ErrorStates {
  versesOfSurah,
  versesOfPage,
  firstPageOfSurah,
  allSurah,
  allAyah,
  countSurah,
  countPage
}

enum LoadingStates {
  versesOfSurah,
  versesOfPage,
  firstPageOfSurah,
  allSurah,
  allAyah,
  countSurah,
  countPage
}

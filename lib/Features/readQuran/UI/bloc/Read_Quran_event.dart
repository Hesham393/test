import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ReadQuranEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

// getAyahsOfPage
class AyahsOfPageEvent extends ReadQuranEvent {
  final int pageNumber;

  AyahsOfPageEvent({@required this.pageNumber});
}

// getAyahsOfSurah

class AyahsOfSurahEvent extends ReadQuranEvent {
  final int surahNumber;

  AyahsOfSurahEvent({@required this.surahNumber});
}

//getFirstPageOfSurah

class FirstPageOfSurahEvent extends ReadQuranEvent {
  final int surahNumber;

  FirstPageOfSurahEvent({@required this.surahNumber});
}

//getCountVersesOfSurah

class CountVersesOfSurahEvent extends ReadQuranEvent {
  final int surahNumber;

  CountVersesOfSurahEvent({@required this.surahNumber});
}

//getCountVersesOfPage

class CountVersesOfPageEvent extends ReadQuranEvent {
  final int pageNumber;

  CountVersesOfPageEvent({@required this.pageNumber});
}

//get All Surah

class AllSurahEvent extends ReadQuranEvent {}

class AllAyahEvent extends ReadQuranEvent {}

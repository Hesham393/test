import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Ayah extends Equatable {
  final int number;
  final String text;
  final int surah;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final int sajda;

  Ayah(
      {@required this.number,
      @required this.text,
      @required this.surah,
      @required this.numberInSurah,
      @required this.juz,
      @required this.manzil,
      @required this.page,
      @required this.ruku,
      @required this.hizbQuarter,
      @required this.sajda});

  @override
  // TODO: implement props
  List<Object> get props => [
        number,
        text,
        surah,
        numberInSurah,
        juz,
        manzil,
        page,
        ruku,
        hizbQuarter,
        sajda
      ];
}

class AyahFields {
  static const String number = "number";
  static const String text = "text";
  static const String surah = "surah";
  static const String numberInSurah = "numberInSurah";
  static const String juz = "juz";
  static const String manzil = "manzil";
  static const String page = "page";
  static const String ruku = "ruku";
  static const String hizbQuarter = "hizbQuarter";
  static const String sajda = "sajda";
}

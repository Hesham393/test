import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EnglishTranslation extends Equatable {
  final int ayah;
  final String translationType;
  final String text;
  final int surah;

  EnglishTranslation(
      {@required this.ayah,
      @required this.translationType,
      @required this.text,
      @required this.surah});

  @override
  // TODO: implement props
  List<Object> get props => [ayah, text, translationType, surah];
}

class EnglishTranslationFields {
  static const String ayah = "ayah";
  static const String translationType = "translationType";
  static const String text = "text";
  static const String surah = "surah";
}

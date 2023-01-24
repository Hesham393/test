import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class kurdishTranslation extends Equatable {
  final int ayah;
  final String translationType;
  final String text;
  final int surah;

  kurdishTranslation(
      {@required this.ayah,
      @required this.translationType,
      @required this.text,
      @required this.surah});

  @override
  // TODO: implement props
  List<Object> get props => [ayah, translationType, text, surah];
}

class kurdishTranslationFields {
  static const String ayah = "ayah";
  static const String translationType = "translationType";
  static const String text = "text";
  static const String surah = "surah";
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AudioAyah extends Equatable {
  final String filePath;
  final String qari;
  final int ayah;
  final int surah;

  const AudioAyah(
      {@required this.filePath,
      @required this.qari,
      @required this.ayah,
      @required this.surah});

  @override
  List<Object> get props => [filePath, qari, ayah, surah];

  factory AudioAyah.fromDB(Map<String, dynamic> data) => AudioAyah(
      ayah: data[AudioAyahFields.ayah],
      qari: data[AudioAyahFields.qari],
      surah: data[AudioAyahFields.surah],
      filePath: data[AudioAyahFields.filePath]);

  Map<String, dynamic> get toDB => {
        AudioAyahFields.ayah: ayah,
        AudioAyahFields.surah: surah,
        AudioAyahFields.filePath: filePath,
        AudioAyahFields.qari: qari,
      };
}

class AudioAyahFields {
  static const String filePath = "filePath";
  static const String qari = "qari";
  static const String ayah = "ayah";
  static const String surah = "surah";
}

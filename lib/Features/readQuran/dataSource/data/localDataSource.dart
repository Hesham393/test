import 'package:flutter/cupertino.dart';

import '../../../../core/sqflite_database/db_helper.dart';
import '../model/ayah_model.dart';
import '../model/surah_model.dart';


abstract class LocalDataSource {
  Future<List<SurahModel>> getAllSurah();
  Future<List<AyahModel>> getAllAyah();
  Future<int> getCountVersesOfPage(int pageNumber);
  Future<int> getCountVersesOfSurah(int surahNumber);
  Future<int> getFirstNumberPageOfSurah(int surahNumber);
  Future<List<AyahModel>> getListAyahsOfSurah(int surahNumber);
  Future<List<AyahModel>> getListOfAyahOfPage(int pageNumber);
}

class LocalDataSourceImp implements LocalDataSource {
  final DBhelper dBhelper;

  LocalDataSourceImp({@required this.dBhelper});

  @override
  Future<List<SurahModel>> getAllSurah() async {
    return await dBhelper.getAllSurah();
  }

  @override
  Future<int> getCountVersesOfPage(int pageNumber) async {
    return await dBhelper.getCountVersesOfPage(pageNumber);
  }

  @override
  Future<int> getCountVersesOfSurah(int surahNumber) async {
    return await dBhelper.getCountVersesOfSurah(surahNumber);
  }

  @override
  Future<int> getFirstNumberPageOfSurah(int surahNumber) async {
    return await dBhelper.getFirstNumberPageOfSurah(surahNumber);
  }

  @override
  Future<List<AyahModel>> getListAyahsOfSurah(int surahNumber) async {
    return await dBhelper.getAyahsOfSurah(surahNumber);
  }

  @override
  Future<List<AyahModel>> getListOfAyahOfPage(int pageNumber) async {
    return await dBhelper.getAyahsOfPage(pageNumber);
  }

  @override
  Future<List<AyahModel>> getAllAyah() async {
    return await dBhelper.getAllAyah();
  }
}

import 'package:flutter/material.dart';

import '../../../core/sqflite_database/db_helper.dart';
import '../domain/entity/ayah.dart';
import '../domain/entity/surah.dart';

abstract class ReadQuranRepository {
  Future<List<Surah>> getAllSurah();

  Future<List<Ayah>> getAllAyah();

  Future<List<Ayah>> getAyahsOfPage(int pageNumber);
  Future<int> getFirstPageOfSurah(int surahNumber);
  Future<Ayah> getFirstAyahOfPage(int pageNumber);
}

class ReadQuranRepositoryImp implements ReadQuranRepository {
  final DBhelper dBhelper;

  ReadQuranRepositoryImp({
    @required this.dBhelper,
  });

  Future<List<Surah>> getAllSurah() async {
    return dBhelper.getAllSurah();
  }

  Future<List<Ayah>> getAllAyah() async {
    return dBhelper.getAllAyah();
  }

  Future<List<Ayah>> getAyahsOfPage(int pageNumber) async {
    return dBhelper.getAyahsOfPage(pageNumber);
  }

  @override
  Future<int> getFirstPageOfSurah(int surahNumber) async {
    return await dBhelper.getFirstNumberPageOfSurah(surahNumber);
  }

  @override
  Future<Ayah> getFirstAyahOfPage(int pageNumber) async {
    return await getAyahsOfPage(pageNumber).then((list) => list.first);
  }
}

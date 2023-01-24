import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entity/ayah.dart';
import '../entity/surah.dart';

abstract class ReadQuranRepository {
  Future<Either<Failure, List<Ayah>>> getListOfAyahOfPage(int pageNumber);

  Future<Either<Failure, List<Ayah>>> getListAyahsOfSurah(int surahNumber);

  Future<Either<Failure, int>> getFirstNumberPageOfSurah(int surahNumber);

  Future<Either<Failure, List<Surah>>> getAllSurah();
  Future<Either<Failure, List<Ayah>>> getAllAyah();

  Future<Either<Failure, int>> getCountVersesOfPage(int pageNumber);

  Future<Either<Failure, int>> getCountVersesOfSurah(int surahNumber);
  Future<Either<Failure, Ayah>> getFirstVerseOfPage(int pageNumber);
}

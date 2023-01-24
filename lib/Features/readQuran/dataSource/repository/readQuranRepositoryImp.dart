import '../data/localDataSource.dart';
import '../../domain/entity/surah.dart';
import '../../domain/entity/ayah.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/readQuranRepository.dart';
import '../../../../core/error/error.dart';
import '../../../../core/failure/failure.dart';

class ReadQuranRepositoryImp implements ReadQuranRepository {
  final LocalDataSource localDataSource;

  ReadQuranRepositoryImp(this.localDataSource);
  @override
  Future<Either<Failure, List<Surah>>> getAllSurah() async {
    try {
      return Right(await localDataSource.getAllSurah());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getCountVersesOfPage(int pageNumber) async {
    try {
      return Right(await localDataSource.getCountVersesOfPage(pageNumber));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getCountVersesOfSurah(int surahNumber) async {
    try {
      return Right(await localDataSource.getCountVersesOfSurah(surahNumber));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getFirstNumberPageOfSurah(
      int surahNumber) async {
    try {
      return Right(
          await localDataSource.getFirstNumberPageOfSurah(surahNumber));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ayah>>> getListAyahsOfSurah(
      int surahNumber) async {
    try {
      return Right(await localDataSource.getListAyahsOfSurah(surahNumber));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ayah>>> getListOfAyahOfPage(
      int pageNumber) async {
    try {
      return Right(await localDataSource.getListOfAyahOfPage(pageNumber));
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Ayah>>> getAllAyah() async {
    try {
      return Right(await localDataSource.getAllAyah());
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Ayah>> getFirstVerseOfPage(int pageNumber) async {
    return await getListOfAyahOfPage(pageNumber).then((list) => list.fold(
        (f) => Left(DatabaseFailure()),
        (listAyah) => Right(listAyah.elementAt(0))));
  }
}

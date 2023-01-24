import 'package:dartz/dartz.dart';

import 'GetListAyahsOfSurah.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

import '../repository/readQuranRepository.dart';

class GetCountVersesOfSurah extends Usecase<int, SurahParam> {
  final ReadQuranRepository repository;

  GetCountVersesOfSurah(this.repository);
  @override
  Future<Either<Failure, int>> call(SurahParam p) async{
   return await repository.getCountVersesOfSurah(p.surahNumber);
  }
}

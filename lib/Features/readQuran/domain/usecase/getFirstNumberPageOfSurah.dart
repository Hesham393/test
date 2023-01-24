import 'package:dartz/dartz.dart';
import '../repository/readQuranRepository.dart';
import 'GetListAyahsOfSurah.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetFirstNumberPageOfSurah extends Usecase<int, SurahParam> {
  final ReadQuranRepository repository;

  GetFirstNumberPageOfSurah(this.repository);

  @override
  Future<Either<Failure, int>> call(SurahParam p) async {
    return await repository.getFirstNumberPageOfSurah(p.surahNumber);
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/ayah.dart';
import '../repository/readQuranRepository.dart';

class GetListAyahsOfSurah extends Usecase<List<Ayah>, SurahParam> {
  final ReadQuranRepository repository;
  GetListAyahsOfSurah(this.repository);
  @override
  Future<Either<Failure, List<Ayah>>> call(SurahParam p) async {
    return await repository.getListAyahsOfSurah(p.surahNumber);
  }
}

class SurahParam extends Equatable {
  final int surahNumber;

  SurahParam(this.surahNumber);
  @override
  // TODO: implement props
  List<Object> get props => [surahNumber];
}

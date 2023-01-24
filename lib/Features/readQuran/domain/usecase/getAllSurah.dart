import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/surah.dart';
import '../repository/readQuranRepository.dart';

class GetAllSurah extends Usecase<List<Surah>, NoParam> {
  final ReadQuranRepository repository;

  GetAllSurah(this.repository);
  @override
  Future<Either<Failure, List<Surah>>> call(NoParam p) async {
    return await repository.getAllSurah();
  }
}

class NoParam extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

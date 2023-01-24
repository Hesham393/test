import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../entity/ayah.dart';
import '../repository/readQuranRepository.dart';
import 'getAllSurah.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllAyah extends Usecase<List<Ayah>, NoParam> {
  final ReadQuranRepository repository;

  GetAllAyah({@required this.repository});

  @override
  Future<Either<Failure, List<Ayah>>> call(NoParam p) async {
    return await repository.getAllAyah();
  }
}

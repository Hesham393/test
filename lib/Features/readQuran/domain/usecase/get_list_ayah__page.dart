import 'package:equatable/equatable.dart';
import '../entity/ayah.dart';
import '../repository/readQuranRepository.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

class GetAyahsOfPage extends Usecase<List<Ayah>, PageNumberParam> {
  ReadQuranRepository repository;

  GetAyahsOfPage(this.repository);
  @override
  Future<Either<Failure, List<Ayah>>> call(param) async {
    return await repository.getListOfAyahOfPage(param.pageNumber);
  }
}

class PageNumberParam extends Equatable {
  final int pageNumber;

  PageNumberParam(this.pageNumber);
  @override
  // TODO: implement props
  List<Object> get props => [pageNumber];
}

import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/readQuranRepository.dart';
import 'get_list_ayah__page.dart';

class GetCountVersesOfPage extends Usecase<int, PageNumberParam> {
  final ReadQuranRepository repository;

  GetCountVersesOfPage(this.repository);
  @override
  Future<Either<Failure, int>> call(PageNumberParam p) async {
    return await repository.getCountVersesOfPage(p.pageNumber);
  }
}

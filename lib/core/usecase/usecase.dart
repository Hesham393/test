



import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class Usecase<type,param>{
Future<Either<Failure,type>>call(param p);
}
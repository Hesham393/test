import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class DatabaseFailure extends Failure {}

class ConnectionFailure extends Failure {}

class FileExceptionFailure extends Failure {}

// class FileIOFailure extends Failure {
//   final String errorMsg;

//   FileIOFailure(this.errorMsg);
// }

// class FileSystemFailure extends Failure {
//   final String errorMsg;

//   FileSystemFailure(this.errorMsg);
// }

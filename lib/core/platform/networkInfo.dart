import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

abstract class NetworkInfo {
  Future<bool> hasConnection();
}

class NetworkInfoImp extends NetworkInfo {
  DataConnectionChecker dataConnectionChecker;

  NetworkInfoImp({@required this.dataConnectionChecker});
  @override
  Future<bool> hasConnection() async =>
      await dataConnectionChecker.hasConnection;
}

import 'package:flutter/material.dart';

class JuzInformation {
  int juzNummber;
  int pageNumber;
  String startE;
  String endE;
  String startA;
  String endA;
  JuzInformation(
      {@required this.pageNumber,
      @required this.juzNummber,
      @required this.startA,
      @required this.endA,
      @required this.startE,
      @required this.endE});

  factory JuzInformation.fromMap(
      int number, int pageNumber, Map<String, String> data) {
    return JuzInformation(
        juzNummber: number,
        pageNumber: pageNumber,
        startA: data["startA"],
        endA: data["endA"],
        startE: data["startE"],
        endE: data["endE"]);
  }
}

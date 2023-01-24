import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Qari extends Equatable {
  final String id;
  final String nation;
  final String name;
  final String englishName;
  final String type;
  final String imagePath;

  const Qari({
    @required this.id,
    @required this.nation,
    @required this.name,
    @required this.englishName,
    @required this.type,
    @required this.imagePath,
  });

  @override
  List<Object> get props => [id, nation, name, englishName, type, imagePath];

  factory Qari.fromDB(Map<String, dynamic> map) {
    return Qari(
        id: map[QariFields.identifier],
        nation: map[QariFields.nation],
        name: map[QariFields.name],
        englishName: map[QariFields.englishName],
        type: map[QariFields.type],
        imagePath: map[QariFields.imagePath]);
  }

  Map<String, String> get toDB {
    return {
      QariFields.identifier: id,
      QariFields.nation: nation,
      QariFields.name: name,
      QariFields.englishName: englishName,
      QariFields.type: type,
      QariFields.imagePath: imagePath
    };
  }
}

class QariFields {
  static const String identifier = "identifier";
  static const String nation = "nation";
  static const String name = "name";
  static const String englishName = "englishName";
  static const String type = "type";
  static const String imagePath = "imagePath";
}

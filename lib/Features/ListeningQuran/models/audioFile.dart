import 'dart:typed_data';

import 'package:flutter/material.dart';

class AudioFile {
  final List<int> bytes;
  final int ayah;
  final String qari;

  AudioFile({@required this.bytes, @required this.ayah, @required this.qari});
}

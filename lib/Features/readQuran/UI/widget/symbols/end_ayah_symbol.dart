import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../providers/providers.dart';
import '../../../../../core/ArabicNumbers/arabic_numbers.dart';
import '../../../../../materialColor/pallete.dart';

import '../../../../../core/constant/constants.dart';

class EndOfAyahSymbol extends ConsumerWidget {
  final int ayahNumber;

  EndOfAyahSymbol({@required this.ayahNumber});

  @override
  Widget build(BuildContext context, ref) {
    final fontSize = ref.watch(quranFontSize);
    final arabicNumber = ArabicNumbers.convert(ayahNumber);

    return CircleAvatar(
      radius: fontSize - 1,
      child: Text("$arabicNumber ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontOptimization(fontSize.toInt()),
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      backgroundColor: pallete.backgroundColor,
      foregroundColor: Colors.red,
      backgroundImage: const AssetImage("assets/images/favEndOfAyah-rvbg.png"),
    );
  }
}

String endOfAyahIcon(int number) {
  final arabicNumber = ArabicNumbers.convert(number);
  return " \ufd3f $arabicNumber \ufd3e ";
}

double fontOptimization(int fontSize) {
  switch (fontSize) {
    case 28:
      return fontSize - 13.5;
    case 27:
      return fontSize - 12.5;
    case 26:
      return fontSize - 11.8;
    case 25:
      return fontSize - 11.8;
    case 24:
      return fontSize - 10.8;
    case 23:
      return fontSize - 10.8;
    case 22:
      return fontSize - 9.7;
    case 21:
      return fontSize - 9.5;
    case 20:
      return fontSize - 8.9;
    case 19:
      return fontSize - 8.6;
    case 18:
      return fontSize - 7.7;
    case 17:
      return fontSize - 7.2;
    case 16:
      return fontSize - 6.7;
    case 15:
      return fontSize - 6.2;
    case 14:
      return fontSize - 5.7;
  }
}

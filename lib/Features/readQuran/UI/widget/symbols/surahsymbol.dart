import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import '../../../providers/providers.dart';


import '../../../../../core/ArabicNumbers/arabic_numbers.dart';

class SurahSymbol extends ConsumerWidget {
  final int number;

  SurahSymbol({@required this.number});

  @override
  Widget build(BuildContext context, ref) {
    final language = ref.watch(languageProvider).getLocale.languageCode;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
            width: 35,
            height: 35,
            child: Image.asset("assets/images/end_Surah-rvbg.png",
                fit: BoxFit.contain)),
        Text("${language == "en" ? number : ArabicNumbers.convert(number)}",
            style: TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }
}

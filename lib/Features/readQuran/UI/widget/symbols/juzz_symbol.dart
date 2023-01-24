import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/ArabicNumbers/arabic_numbers.dart';
import '../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../providers/providers.dart';

class JuzzSymbol extends StatelessWidget {
  final int juzNumber;
  JuzzSymbol({@required this.juzNumber});

  @override
  Widget build(BuildContext context) {
    ThemeConfig().init(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset("assets/images/juzz_icon_rbg.png", fit: BoxFit.contain),
        Consumer(builder: (context, ref, _) {
          final lan = ref.watch(languageProvider).getLocale.languageCode;
          final number =
              lan == "en" ? juzNumber : ArabicNumbers.convert(juzNumber);
          return Text(lan == "en" ? "Juz $number" : "جزء $number",
              style: ThemeConfig.headline1.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54));
        })
      ],
    );
  }
}

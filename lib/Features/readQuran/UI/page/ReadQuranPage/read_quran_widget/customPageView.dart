import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../providers/providers.dart';
import '../../../widget/symbols/end_page_symbol.dart';

import '../../../../domain/entity/ayah.dart';
import 'ayah_widget.dart';

class CustompageView extends StatelessWidget {
  final List<Ayah> ayahs;

  CustompageView({@required this.ayahs});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: Center(
        // child: Card(
        //   shadowColor: pallete.backgroundColor,
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15)),
        //   color: pallete.backgroundColor,
        //   elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // if (ayahs[0].text.length >= 38)
              //   if (ayahs[0].text.substring(0, 38) == bismila)
              //     Consumer(builder: (context, ref, _) {
              //       final font = ref.watch(quranFontSize);
              //       return Text(
              //         "$bismila  ",
              //         style: basmalaStyle.copyWith(fontSize: font + 2),
              //         textAlign: TextAlign.center,
              //       );
              //     }),
              Consumer(builder: (context, ref, _) {
                
                return RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(children: getContent(context, ref)),
                  textAlign: TextAlign.center,
                );
              }),
              EndPageSymbol(pageNumber: ayahs[0].page),
            ],
          ),
        ),

        // ),
      ),
    );
  }

  List<TextSpan> getContent(BuildContext context, WidgetRef ref) {
    return List<TextSpan>.generate(ayahs.length, (index) {
      return getSpan(context, ayahs[index], ref, index);
    });
  }
}

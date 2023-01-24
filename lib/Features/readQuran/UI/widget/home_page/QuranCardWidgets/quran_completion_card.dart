import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/constant/constants.dart';
import '../../../../../../core/responsiveness/responsive.dart';
import 'complection_percent.dart';
import 'quran_completion_image.dart';

class QuranCompletionCard extends StatelessWidget {
  const QuranCompletionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: atlanticGullColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefalultHorizontalPadding,
                vertical: kDefalultVerticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).qurancompletion,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.white)),
                SizedBox(
                  height: getPercentageOfResponsiveHeight(10, context),
                ),
                Text("Last Read Al Baqara 28 ",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: getPercentageOfResponsiveHeight(8, context),
                ),
                CompletionPercent(),
                SizedBox(
                  height: getPercentageOfResponsiveHeight(10, context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: getPercentageOfResponsiveWidth(10, context),
          ),
          QuranComImage(),
          SizedBox(
            width: getPercentageOfResponsiveWidth(10, context),
          ),
        ],
      ),
    );
  }
}

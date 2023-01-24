import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/widget/home_page/QuranAccessingSelection/bookmarks_selection/bookmark_screen.dart';
import 'juz_selection/juzSelection.dart';
import 'selection_surah_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'surah_selection/surah_indexing_controller.dart';

import '../../../../providers/providers.dart';

enum SelectHomeStates { Surah, Juz, Bookmarks }

final bucketKey = PageStorageBucket();

class SelectionSurahListHome extends StatelessWidget {
  const SelectionSurahListHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucketKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectionSurahItem(
                    ownState: SelectHomeStates.Surah,
                    title: AppLocalizations.of(context).surah),
                // SizedBox(width: getPercentageOfResponsiveWidth(10, context)),
                SelectionSurahItem(
                  ownState: SelectHomeStates.Juz,
                  title: AppLocalizations.of(context).juz,
                ),
                //SizedBox(width: getPercentageOfResponsiveWidth(10, context)),
                SelectionSurahItem(
                  ownState: SelectHomeStates.Bookmarks,
                  title: AppLocalizations.of(context).bookmarks,
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer(builder: (context, ref, widget) {
              return getSelection(ref.watch(accessQuranSelectedState));
            }),
          )
        ],
      ),
    );
  }
}

Widget getSelection(String state) {
  switch (state) {
    case "Surah":
      return const SurahIndexingController();
    case "Juz":
      return JuzSelection();
    case "Bookmarks":
      return BookmarkScreen();
    default:
      return Container();
  }
}

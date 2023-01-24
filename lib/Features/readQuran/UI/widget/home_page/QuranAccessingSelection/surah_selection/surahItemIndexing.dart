import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../../ListeningQuran/Providers/providers.dart';
import '../../../../../../ListeningQuran/UI/pages/AudioController/customPlaylist.dart';

import '../../../symbols/surahsymbol.dart';
import '../../../../../providers/providers.dart';
import '../../../../../../../core/ArabicNumbers/arabic_numbers.dart';

import '../../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../domain/entity/surah.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurahItemIndexing extends ConsumerWidget {
  final Surah surah;

  const SurahItemIndexing({
    @required this.surah,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeConfig().init(context);
    final language = ref.watch(languageProvider).getLocale.languageCode;
    final _selectedSurah = ref.watch(SelectedSurahIndexProvider);
    return Container(
      child: ListTile(
        leading: SurahSymbol(number: surah.number),
        title: Text(language == "en" ? surah.englishName : surah.name,
            style: ThemeConfig.juzStartFont.copyWith(
                color: (_selectedSurah == surah.number &&
                        Scaffold.of(context).isDrawerOpen)
                    ? ThemeConfig.pColor
                    : null)),
        subtitle: Text(
          "${AppLocalizations.of(context).verses} ${language == "en" ? surah.numberOfAyahs : ArabicNumbers.convert(surah.numberOfAyahs)}",
          style: ThemeConfig.subtitle1,
        ),
        trailing: Consumer(builder: (context, ref, _) {
          final pageNumber = ref
              .read(firstPageOfSurahProvider)
              .getPageNumberOfSurah(surah.englishName);

          return Text(
              "${language == "en" ? pageNumber : ArabicNumbers.convert(pageNumber)}");
        }),
        onTap: () => onSurahTap(context, ref),
        selectedColor: ThemeConfig.pColor,
        selected: (_selectedSurah == surah.number &&
            Scaffold.of(context).isDrawerOpen),
      ),
    );
  }

  void onSurahTap(BuildContext context, WidgetRef ref) {
    if (Scaffold.of(context).isDrawerOpen) {
      final pageNumber = ref
          .read(firstPageOfSurahProvider)
          .getPageNumberOfSurah(surah.englishName);

      //make scroll to the selected surah

      final readQuranScrollController =
          ref.read(readQuranScrollControllerProvider);
      if (readQuranScrollController.isAttached &&
          !ref.read(customPlaylistProvider).isPlay) {
        readQuranScrollController.navigateToReadedAyah(pageNumber - 1);
        // function surah to be selected in the list when user come back to drawer
        ref.read(SelectedSurahIndexProvider.notifier).state = surah.number;
      }

      //closing the drawer
      if (Scaffold.of(context).isDrawerOpen) {
        Scaffold.of(context).closeDrawer();
      }
    }
  }
}

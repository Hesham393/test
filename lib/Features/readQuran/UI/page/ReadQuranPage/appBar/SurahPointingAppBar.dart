import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../providers/providers.dart';
import '../../../widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';

class SurahPointingAppBar extends ConsumerWidget {
  const SurahPointingAppBar({
    Key key,
  }) : super(key: key);

  void _onPressed(BuildContext context, WidgetRef ref) {
    if (!Scaffold.of(context).isDrawerOpen) {
      ref.read(accessQuranSelectedState.notifier).state =
          SelectHomeStates.Surah.name;
      Scaffold.of(context).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final index = ref.watch(quranPageIndexProvider);
    final lan = ref.watch(languageProvider).getLocale.languageCode;
    final pageToSurah = lan == "en"
        ? ref.read(firstPageOfSurahProvider).getEnglishSurah(index)
        : ref.read(firstPageOfSurahProvider).getArabicSurah(index);

    final surahNumber = ref.read(firstPageOfSurahProvider).getSurahNumber(
        ref.read(firstPageOfSurahProvider).getEnglishSurah(index));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(SelectedSurahIndexProvider.notifier).state = surahNumber;
    });

    return TextButton(
      child: Text("$pageToSurah ", style: ThemeConfig.appBarStyle),
      onPressed: (() => _onPressed(context, ref)),
    );
  }
}

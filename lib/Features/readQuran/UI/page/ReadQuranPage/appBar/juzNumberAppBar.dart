import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../core/ArabicNumbers/arabic_numbers.dart';
import '../../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../providers/providers.dart';
import '../../../widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';


class juzNumberAppBar extends ConsumerWidget {
  const juzNumberAppBar({
    Key key,
  }) : super(key: key);

  void _onPressed(BuildContext context, WidgetRef ref) {
    if (!Scaffold.of(context).isDrawerOpen) {
      ref.read(accessQuranSelectedState.notifier).state =
          SelectHomeStates.Juz.name;
      Scaffold.of(context).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    ThemeConfig().init(context);
    final pageNumber = ref.watch(quranPageIndexProvider);
    final juzNumber = ref.read(getJuzByPageProvider(pageNumber));
    final lan = ref.watch(languageProvider).getLocale.languageCode;
    return TextButton(
        child: Text(
          lan == "en"
              ? "${AppLocalizations.of(context).juz} $juzNumber"
              : "${AppLocalizations.of(context).juz} ${ArabicNumbers.convert(juzNumber)}",
          textAlign: TextAlign.center,
          style: ThemeConfig.appBarStyle,
        ),
        onPressed: (() => _onPressed(context, ref)));
  }
}

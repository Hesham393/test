import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../../ListeningQuran/Providers/providers.dart';
import '../../../symbols/juzz_symbol.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../core/ArabicNumbers/arabic_numbers.dart';
import '../../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../Models/juz.dart';
import '../../../../../providers/providers.dart';

class juzSelectionItem extends ConsumerWidget {
  final JuzInformation juz;
  const juzSelectionItem({
    @required this.juz,
    Key key,
  }) : super(key: key);

  void onTapJuz(BuildContext context, WidgetRef ref) {
    if (Scaffold.of(context).isDrawerOpen &&
        !ref.read(customPlaylistProvider).isPlay) {
      ref
          .read(readQuranScrollControllerProvider)
          .navigateToReadedAyah(juz.pageNumber - 1);
      Scaffold.of(context).closeDrawer();
      ref.read(juzSelectedIndexProvider.notifier).state = juz.juzNummber;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    ThemeConfig().init(context);
    final lang = ref.watch(languageProvider).getLocale.languageCode;
    final selectedJuz = ref.watch(juzSelectedIndexProvider);
    final color =
        selectedJuz == juz.juzNummber ? ThemeConfig.pColor : Colors.black87;
    return ListTile(
      leading: JuzzSymbol(juzNumber: juz.juzNummber),
      title: Text.rich(
        TextSpan(
            children: [
              TextSpan(
                  text: lang == "en" ? "${juz.startE}" : "${juz.startA}",
                  style: ThemeConfig.juzStartFont.copyWith(color: color))
            ],
            text: "${AppLocalizations.of(context).start} ",
            style: ThemeConfig.subtitle1),
      ),
      subtitle: Text.rich(
        TextSpan(
            children: [
              TextSpan(
                  text: lang == "en" ? "${juz.endE} " : "${juz.endA} ",
                  style: ThemeConfig.juzStartFont
                      .copyWith(fontSize: 11, color: color))
            ],
            text: "${AppLocalizations.of(context).end} ",
            style: ThemeConfig.subtitle1),
      ),
      trailing: Text(
          lang == "en"
              ? "${juz.pageNumber}"
              : "${ArabicNumbers.convert(juz.pageNumber)}",
          style: TextStyle(color: color)),
      onTap: () => onTapJuz(context, ref),
    );
  }
}

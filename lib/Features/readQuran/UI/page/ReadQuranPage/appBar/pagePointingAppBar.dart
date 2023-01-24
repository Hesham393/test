import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quran_twekl_app/Features/Bookmark/model/bookmark_model.dart';
import 'package:quran_twekl_app/Features/Bookmark/provider/providers.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../../../core/ArabicNumbers/arabic_numbers.dart';
import '../../../../providers/providers.dart';

class pagePointingAppBar extends ConsumerWidget {
  const pagePointingAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ThemeConfig().init(context);
    final page = ref.watch(quranPageIndexProvider);
    final lan = ref.watch(languageProvider).getLocale.languageCode;
    final isBookmarked =
        ref.watch(bookmarkManagementProvider).isBookmarkedPage(page);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          icon: isBookmarked
              ? const Icon(Icons.bookmark_outlined)
              : const Icon(Icons.bookmark_outline_sharp),
          // bookmark_outline_sharp
          // child: Text(
          //     lan == "en"
          //         ? "${AppLocalizations.of(context).page} $page"
          //         : "${AppLocalizations.of(context).page} ${ArabicNumbers.convert(page)}",
          //     style: ThemeConfig.appBarStyle
          //         .copyWith(color: Colors.white70, fontSize: 12)),
          onPressed: () async {
            // ref.read(bottomNavigationIndexProvider.notifier).state = 0;
            // Navigator.pushReplacementNamed(context, HomePage.routeName);
            if (!isBookmarked) {
              final ayah =
                  await ref.read(readQuranRepository).getFirstAyahOfPage(page);
              String text = ayah.text;
              if (page != 1 && ayah.numberInSurah == 1) {
                text = ayah.text.substring(38);
              }
              await ref.read(bookmarkManagementProvider).add(Bookmark(
                  dateTime: DateTime.now().toString(),
                  ayah: text,
                  pageNumber: page,
                  bookmarkType: BookmarkType.page.name));
            } else {
              ref.read(bookmarkManagementProvider).remove_pageBookmark(page);
            }

            //final bookmarks= ref.read(bookmarksProvider).asData;
            // Scaffold.of(context).openDrawer();
          },
        ),
        Text(
            lan == "en"
                ? "${AppLocalizations.of(context).page} $page"
                : "${AppLocalizations.of(context).page} ${ArabicNumbers.convert(page)}",
            style: ThemeConfig.appBarStyle
                .copyWith(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

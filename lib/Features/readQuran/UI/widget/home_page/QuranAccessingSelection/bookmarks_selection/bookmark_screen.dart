import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quran_twekl_app/Features/readQuran/providers/providers.dart';
import 'package:quran_twekl_app/core/ArabicNumbers/arabic_numbers.dart';
import 'package:quran_twekl_app/core/constant/constants.dart';
import 'package:quran_twekl_app/materialColor/pallete.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../core/sizeConfig/theme_configuration.dart';

import '../../../../../../Bookmark/model/bookmark_model.dart';
import '../../../../../../Bookmark/provider/providers.dart';
import '../../../../../providers/get_first_page_surah.dart';

class BookmarkScreen extends ConsumerWidget {
  static String routeName = "BookmarkScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkManagementProvider).getAll;

    return ListView.builder(
      itemBuilder: (context, index) {
        return bookmark_item(
          key: UniqueKey(),
          bookmark: bookmarks[index],
        );
      },
      itemCount: bookmarks.length,
    );
  }
}

class bookmark_item extends ConsumerWidget {
  final Bookmark bookmark;
  const bookmark_item({
    @required this.bookmark,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = DateTime.parse(bookmark.dateTime);
    final date = DateFormat.yMd().add_Hm().format(dateTime);
    final lang = ref.watch(languageProvider).getLocale.languageCode;
    ThemeConfig().init(context);
    return Dismissible(
      key: key,
      onDismissed: (direction) async {
        await ref.read(bookmarkManagementProvider).remove(bookmark);
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Theme.of(context).errorColor,
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
        alignment: lang == "en" ? Alignment.centerLeft : Alignment.centerRight,
      ),
      child: GestureDetector(
        onTap: () async {
          Scaffold.of(context).closeDrawer();

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await ref.read(readQuranScrollControllerProvider).animatedToIndex(
                bookmark.pageNumber - 1, const Duration(milliseconds: 350));
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 100,
            child: Card(
              color: pallete.ayahColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                // isThreeLine: true,
                leading: Icon(
                  Icons.bookmark_outlined,
                  color: bookmark.bookmarkType == BookmarkType.Ayah.name
                      ? pallete.ayahBookmarkColor
                      : Colors.black,
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookmark.bookmarkType == BookmarkType.page.name
                          ? "${AppLocalizations.of(context).page} " +
                              (lang != "en"
                                  ? "${ArabicNumbers.convert(bookmark.pageNumber)}"
                                  : "${bookmark.pageNumber}")
                          : lang == "en"
                              ? "${MapPageToSurah.getEnglishSurahBySurahNO(bookmark.surah)}"
                              : " ${MapPageToSurah.getAraciSurahBySurahNO(bookmark.surah)} ",
                      style: ThemeConfig.generalHeadline.copyWith(fontSize: 12),
                    ),
                    Text(" ${bookmark.ayah} ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: quranBodyText.copyWith(
                          fontSize: 11,
                        )),
                  ],
                ),
                trailing: CircleAvatar(
                  backgroundColor: pallete.ayahColor,
                  foregroundColor: Colors.black,
                  child: Text(
                    "${bookmark.pageNumber}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                // isThreeLine: true,
                subtitle: Text(
                  "${date}",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

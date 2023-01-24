import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/Bookmark/model/bookmark_model.dart';
import 'package:quran_twekl_app/Features/Bookmark/provider/providers.dart';
import 'package:quran_twekl_app/main.dart';
import '../../../../../ListeningQuran/Providers/providers.dart';
import '../../../../../../materialColor/pallete.dart';
import '../../../widget/symbols/end_ayah_symbol.dart';
import '../../../../providers/providers.dart';
import '../../../../../../core/constant/constants.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../domain/entity/ayah.dart';

class TextHighlightNotifier extends ChangeNotifier {
  int _surah = 0;
  int _index = -1;
  final _color = pallete.textHightlightColor;

  void setTextHighlight(int surah, int index) {
    _surah = surah;
    _index = index;
    notifyListeners();
  }

  void clear() {
    _surah = 0;
    _index = -1;
    notifyListeners();
  }

  bool isPressed(int surah, int numberInsurah) =>
      surah == _surah && numberInsurah == _index;

  Color get getColor => _color;
}

final textHighlightProvider = ChangeNotifierProvider<TextHighlightNotifier>(
    (ref) => TextHighlightNotifier());

TextSpan getSpan(BuildContext context, Ayah ayah, WidgetRef ref, int index) {
  final fontSize = ref.watch(quranFontSize);

  ThemeConfig().init(context);
  // ref.watch(customPlaylistProvider).surahNumber;
  // ref.watch(customPlaylistProvider).ayahIndex;
  final isPressed = ref
      .watch(textHighlightProvider)
      .isPressed(ayah.surah, ayah.numberInSurah - 1);
  final isBookmarked = ref.watch(bookmarkManagementProvider).isBookmarked(ayah);
  return TextSpan(
      children: [
        if (ayah.numberInSurah == 1)
          TextSpan(
            text: index == 0 ? "$bismila\n " : "\n$bismila\n ",
            style: quranBodyText.copyWith(color: ThemeConfig.pColor),
          ),
        if (ayah.numberInSurah == 1 && ayah.text.length >= 38)
          TextSpan(
              text: "${ayah.text.substring(38)} ",
              style: quranBodyText.copyWith(
                  color: isHighlighted(ayah.surah, ayah, ref) || isPressed
                      ? pallete.textHightlightColor
                      : null,
                  fontSize: fontSize),
              recognizer: _getLongPressRecognizer(
                  ref: ref, ayah: ayah, context: context)),
        TextSpan(
          text: endOfAyahIcon(ayah.numberInSurah),
          style: TextStyle(
              fontSize: fontSize - 6,
              //FEBF63,FFBCBC
              color: isBookmarked ? Color(0xFFFFBCBC) : ThemeConfig.sColor),
        ),
      ],

      ///${ayah.text.substring(38)}
      text: ayah.numberInSurah == 1 && ayah.text.length >= 38 ? "" : ayah.text,
      style: quranBodyText.copyWith(
          color: isHighlighted(ayah.surah, ayah, ref) || isPressed
              ? pallete.textHightlightColor
              : null,
          fontSize: fontSize),
      recognizer:
          _getLongPressRecognizer(ref: ref, ayah: ayah, context: context));
}

LongPressGestureRecognizer _getLongPressRecognizer(
        {WidgetRef ref, Ayah ayah, BuildContext context}) =>
    LongPressGestureRecognizer(duration: const Duration(milliseconds: 200))
      ..onLongPress = () async {
        ref
            .read(textHighlightProvider)
            .setTextHighlight(ayah.surah, ayah.numberInSurah - 1);

        await showCustomDialog(
            context: context,
            ref: ref,
            ayah: ayah,
            qari: ref.read(selectedQariProvider).getQari.id);
        ref.read(textHighlightProvider).clear();
        // ref
        //     .read(textHighlightProvider)
        //     .setTextHighlight(ayah.surah, ayah.numberInSurah - 1);
      };

Future<void> showCustomDialog(
    {BuildContext context, WidgetRef ref, Ayah ayah, String qari}) async {
  await showDialog(
    context: context,
    builder: (context) => OnAyahClickDialog(
      ayah: ayah,
      qari: qari,
    ),
  );
}

class OnAyahClickDialog extends ConsumerWidget {
  final Ayah ayah;
  final String qari;
  const OnAyahClickDialog({
    @required this.ayah,
    @required this.qari,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text("play current verse only"),
              onPressed: () async {
                final cusAudioProvider = ref.read(customAudioPlayerProvider);
                if (cusAudioProvider.isFunctionSet) {
                  await cusAudioProvider.playCurrentAyahOrStartingFromCurrent(
                      surahNumber: ayah.surah,
                      ayahIndex: ayah.numberInSurah - 1,
                      qari: qari,
                      isOnlyAyah: true);
                }
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("play starting from this"),
              onPressed: () async {
                final cusAudioProvider = ref.read(customAudioPlayerProvider);
                if (cusAudioProvider.isFunctionSet) {
                  await cusAudioProvider.playCurrentAyahOrStartingFromCurrent(
                    surahNumber: ayah.surah,
                    ayahIndex: ayah.numberInSurah - 1,
                    qari: qari,
                  );
                }
                Navigator.pop(context);
              },
            ),
            Consumer(builder: (context, ref, child) {
              final isBookmarked =
                  ref.watch(bookmarkManagementProvider).isBookmarked(ayah);
              return IconButton(
                onPressed: () async {
                  if (!isBookmarked) {
                    String text = ayah.text;
                    if (ayah.page != 1 && ayah.numberInSurah == 1) {
                      text = ayah.text.substring(38);
                    }
                    final bookmark = Bookmark(
                        dateTime: DateTime.now().toString(),
                        ayah: text,
                        pageNumber: ayah.page,
                        bookmarkType: BookmarkType.Ayah.name,
                        surah: ayah.surah);
                    ref.read(bookmarkManagementProvider).add(bookmark);
                  } else {
                    await ref
                        .read(bookmarkManagementProvider)
                        .remove_ayahBookmark(ayah);
                  }
                },
                icon: isBookmarked
                    ?const Icon(Icons.bookmark_outlined,color: pallete.ayahBookmarkColor,)
                    : const Icon(Icons.bookmark_outline_sharp,color: pallete.ayahBookmarkColor,),
              );
            })
          ]),
    );
  }
}

void ayahPressedExecution(int surah, int ayah, WidgetRef ref) {
  ref.read(textHighlightProvider).setTextHighlight(surah, ayah);
}

bool isHighlighted(int surah, Ayah ayah, WidgetRef ref) {
  final selectedSurah = ref.watch(customPlaylistProvider).surahNumber;
  final selectedAyah = ref.watch(customPlaylistProvider).ayahIndex;

  if (selectedAyah == (ayah.numberInSurah - 1) && selectedSurah == surah) {
    final readQuranScrollController =
        ref.read(readQuranScrollControllerProvider);
    final customPlaylist = ref.watch(customPlaylistProvider).isPlay;
    if (readQuranScrollController.isAttached && customPlaylist) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        readQuranScrollController.navigateToReadedAyah(ayah.page - 1);
      });
    }

    return true;
  }
  return false;
}

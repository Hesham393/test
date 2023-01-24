import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../Providers/providers.dart';

import '../../../../../../materialColor/pallete.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../readQuran/domain/entity/surah.dart';
import 'downloadStatus.dart';

class mediaSurahItem extends ConsumerWidget {
  final Surah surah;
  const mediaSurahItem({
    @required this.surah,
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<Surah> list;

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        // color: pallete.ayahColor,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        decoration: BoxDecoration(
            color: pallete.ayahColor,
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          child: ListTile(
            leading:
                Text("${surah.number}", style: ThemeConfig.generalHeadline),
            trailing: downloadStatus(
              surah: surah,
            ),
            title: Text("${surah.englishName} ",
                style: ThemeConfig.generalHeadline),
            onTap: () async {
              final data = await ref
                  .read(listeningQuranRepositoryProvider)
                  .getAudioAyahsOfSurah(surah.number, "ar.abdulsamad");
            },
          ),
        ),
      ),
    );
  }
}

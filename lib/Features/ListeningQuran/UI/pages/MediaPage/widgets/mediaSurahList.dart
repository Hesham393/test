import 'package:flutter/material.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../readQuran/domain/entity/surah.dart';
import 'mediaSurahItem.dart';

class mediaSurahList extends StatelessWidget {
  final List<Surah> list;
  const mediaSurahList({
    @required this.list,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeConfig().init(context);
    return ListView.builder(
      itemBuilder: ((context, index) => mediaSurahItem(
            surah: list[index],
          )),
      itemCount: list.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../Providers/providers.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../../materialColor/pallete.dart';

import '../../../../models/qariModel.dart';
import '../../MediaPage/widgets/qariImage.dart';

class QariItem extends ConsumerWidget {
  final Qari qari;
  const QariItem({
    @required this.qari,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ThemeConfig().init(context);
    return InkWell(
      onTap: () {
        ref.read(selectedQariProvider).setQari(qari);
        Navigator.of(context).pop();
      },
      child: Card(
          color: pallete.ayahColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              title: Text("${qari.englishName}",
                  style: ThemeConfig.generalHeadline),
              trailing: qariImage(imagePath: qari.imagePath),
            ),
          )),
    );
  }
}

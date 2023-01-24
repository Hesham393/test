import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'selection_surah_list_home.dart';
import '../../../../../../core/responsiveness/responsive.dart';
import '../../../../../../core/sizeConfig/size_config.dart';
import '../../../../../../core/constant/constants.dart';
import '../../../../providers/providers.dart';

class SelectionSurahItem extends ConsumerWidget {
  final String title;
  final SelectHomeStates ownState;
  const SelectionSurahItem({
    @required this.ownState,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    SizeConfig().init(context);

    final selectedState = ref.watch(accessQuranSelectedState);
    return GestureDetector(
      onTap: () {
        ref.read(accessQuranSelectedState.notifier).state = ownState.name;
      },
      child: SizedBox(
        width: Scaffold.of(context).isDrawerOpen
            ? SizeConfig.screenWidth * 0.2
            : SizeConfig.screenWidth * 0.3,
        height: getPercentageOfResponsiveHeight(70, context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 14)),
            const SizedBox(
              height: 2,
            ),
            if (selectedState == ownState.name)
              Container(
                height: 5,
                width: Scaffold.of(context).isDrawerOpen
                    ? SizeConfig.screenWidth * 0.2
                    : SizeConfig.screenWidth * 0.3,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: mainGradientColors,
                )),
              )
          ],
        ),
      ),
    );
  }
}

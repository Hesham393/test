import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Providers/providers.dart';
import 'widgets/qariSelectionList.dart';
import '../../../../../core/constant/constants.dart';
import '../../../../../core/sizeConfig/size_config.dart';
import '../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../../materialColor/pallete.dart';

class RecitersPage extends StatelessWidget {
  // final Qari selectedReciter;

  // RecitersPage({
  //   @required this.selectedReciter,
  // });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: CustomScrollView(slivers: [
        SliverSafeArea(
          sliver: SliverAppBar(
            shape: appBarShape,
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: pallete.primaryColor,
            expandedHeight: SizeConfig.screenHeight / 6,
            flexibleSpace: qariImageFlexibleSpace(),
          ),
        ),
        qariSelectionList(),
      ]),
    );
  }
}

class qariImageFlexibleSpace extends ConsumerWidget {
  const qariImageFlexibleSpace({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ThemeConfig().init(context);
    final qari = ref.watch(selectedQariProvider).getQari;
    return FlexibleSpaceBar(
      title: Text(qari.englishName,
          style: ThemeConfig.headline1
              .copyWith(fontSize: 15, color: Colors.white)),
      centerTitle: true,
      background: Image.asset(qari.imagePath),
    );
  }
}

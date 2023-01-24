import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Providers/providers.dart';
import 'widgets/mediaSurahList.dart';
import 'widgets/qariImage.dart';
import '../recitersPage.dart/reciterPage.dart';
import '../../../../readQuran/UI/page/home_page.dart';
import '../../../../readQuran/UI/widget/custom_bottom_navigation_home.dart';
import '../../../../readQuran/providers/providers.dart';
import '../../../../../core/responsiveness/responsive.dart';
import '../../../../../core/sizeConfig/theme_configuration.dart';

final PageStorageBucket mediaBucketkey = PageStorageBucket();

class MediaPage extends ConsumerWidget {
  static const String routeName = "/MediaPage";

  @override
  Widget build(BuildContext context, ref) {
    const radius = Radius.elliptical(60, 20);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: radius)),
        toolbarHeight: 60,
        leading: selectedQariAppBar(),
        leadingWidth: 100,
        title: const Text("Media Library"),
        flexibleSpace: const LinearColor(),
        centerTitle: true,
      ),
      body: PageStorage(
        bucket: mediaBucketkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefalultHorizontalPadding,
              vertical: kDefalultVerticalPadding),
          child: _buildBody(context, ref),
        ),
      ),
      // bottomNavigationBar: const customBottomNavigationBarHome(currentPage: 2),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    ThemeConfig().init(context);
    final _data = ref.watch(allSurahProvider);
    return _data.when(
        data: (data) => mediaSurahList(
              list: data,
              key: const PageStorageKey<String>("MediaList"),
            ),
        error: (error, stackTrace) => const SizedBox(),
        loading: (() => const SizedBox()));
  }
}

class selectedQariAppBar extends ConsumerWidget {
  const selectedQariAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final selectedQari = ref.watch(selectedQariProvider).getQari.imagePath;
    return TextButton(
      child: qariImage(
        imagePath: selectedQari,
        isSelected: true,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecitersPage(),
        ));
      },
    );
  }
}

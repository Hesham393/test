import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/Bookmark/provider/providers.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/scrollToHideWidget.dart';
import 'package:quran_twekl_app/Features/readQuran/providers/providers.dart';
import 'package:quran_twekl_app/core/sizeConfig/theme_configuration.dart';
import '../../../../core/constant/constants.dart';
import '../../../../core/fonts/font.dart';
import '../../../../core/responsiveness/responsive.dart';
import '../../../../materialColor/pallete.dart';
import '../../../Adhan/UI/adhan_screen.dart';
import '../../../ListeningQuran/UI/pages/MediaPage/mediaPage.dart';
import '../widget/custom_bottom_navigation_home.dart';
import '../widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';
import '../widget/home_page/QuranCardWidgets/quran_completion_card.dart';
import '../widget/home_page/home_drawer.dart';
import '../widget/home_page/quick_access_list.dart';
import 'ReadQuranPage/ReadQuranPage.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = "/HomePage";

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class MyHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(bookmarkManagementProvider).getAll;
    ThemeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
            title: const Text("Home"),
            shape: appBarShape,
            flexibleSpace: const LinearColor()),
        drawer: HomeDrawer(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            DateTime dateTime = DateTime.parse(data[index].dateTime);
            final d = DateTime.now().difference(dateTime);
            print(d.inMinutes);
            final date = DateFormat.yMd().format(dateTime);
            return ListTile(
              title: Text(
                "${data[index].ayah}",
                style: ThemeConfig.generalHeadline,
              ),
              trailing: Text("${date.toString()}"),
              subtitle: Text("PageNumber: ${data[index].pageNumber}"),
            );
          },
          itemCount: data.length,
        )
        // data.when(
        //     data: (data) => ListView.builder(
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               title: Text("${data[index].dateTime}"),
        //             );
        //           },
        //           itemCount: data.length,
        //         ),
        //     error: (error, stackTrace) => Center(child: Text("error occured",style: TextStyle(color:Colors.red),),),
        //     loading: () => const CircularProgressIndicator()),
        );
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  // HomePage(),
  static final List<Widget> _screenOptions = <Widget>[
    MyHome(),
    ReadQuranPage(),
    MediaPage(),
    AdhanScreen()
  ];

  int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = 0;
    super.initState();
  }

  void onTapBtn(int index) {
    setState(() {
      _selectedIndex = index;
      ref.read(bottomNavigationIndexProvider.notifier).state = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     shape: appBarShape,
      //     leading: Builder(
      //       builder: (context) => IconButton(
      //         icon: Icon(Icons.settings),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       ),
      //     ),
      //     flexibleSpace: const LinearColor()),
      bottomNavigationBar: ScrollToHideWidget(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 15,
          selectedItemColor: pallete.secondaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Quran"),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_note), label: "Media"),
            BottomNavigationBarItem(icon: Icon(Icons.mosque), label: "Adhan"),
          ],
          currentIndex: _selectedIndex,
          onTap: onTapBtn,
        ),
      ),
      // const customBottomNavigationBarHome(
      //   currentPage: 0,
      // ),
      drawer: HomeDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _screenOptions[_selectedIndex];
    // SizedBox(
    //   width: double.infinity,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(
    //         horizontal: kDefalultHorizontalPadding,
    //         vertical: kDefalultVerticalPadding),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // title of page
    //         Text(AppLocalizations.of(context).qurankareem,
    //             style: Theme.of(context).textTheme.headline1),
    //         SizedBox(
    //           height: getPercentageOfResponsiveHeight(7, context),
    //         ),
    //         QuranCompletionCard(),
    //         SizedBox(
    //           height: getPercentageOfResponsiveHeight(20, context),
    //         ),

    //         const Text(
    //           "Quick Access",
    //           style: TextStyle(
    //               color: Color(
    //                 0xffb9b9b9,
    //               ),
    //               fontFamily: Fonts.roboto),
    //         ),
    //         SizedBox(
    //           height: getPercentageOfResponsiveHeight(10, context),
    //         ),
    //         const QuickAccessList(),
    //         SizedBox(
    //           height: getPercentageOfResponsiveHeight(12, context),
    //         ),
    //         const Expanded(child: SelectionSurahListHome()),
    //         // BlocListener<ReadQuranBloc, ReadQuranState>(
    //         //   listener: (context, state) {
    //         //     if (state is AllSurahState) {
    //         //       print("allSurah state is success");
    //         //     }
    //         //   },
    //         //   child: Container(),
    //         // )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class LinearColor extends StatelessWidget {
  const LinearColor({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: appBarRadius),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: pallete.mainGradientColor),
      ),
    );
  }
}

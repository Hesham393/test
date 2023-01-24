import 'package:flutter/material.dart';
import '../../../Adhan/UI/adhan_screen.dart';
import '../../../ListeningQuran/UI/pages/MediaPage/mediaPage.dart';
import '../../../../materialColor/pallete.dart';

import '../../../../core/constant/constants.dart';
import '../page/ReadQuranPage/ReadQuranPage.dart';
import '../page/home_page.dart';

class customBottomNavigationBarHome extends StatefulWidget {
  final int currentPage;
  const customBottomNavigationBarHome({
    @required this.currentPage,
    Key key,
  }) : super(key: key);

  @override
  State<customBottomNavigationBarHome> createState() =>
      _customBottomNavigationBarHomeState();
}

class _customBottomNavigationBarHomeState
    extends State<customBottomNavigationBarHome> {
      static final List<Widget> _screenOptions = <Widget>[
    HomePage(),
    ReadQuranPage(),
    MediaPage(),
    AdhanScreen()
  ];
  int _currentPage;
  @override
  void initState() {
    _currentPage = widget.currentPage;
    super.initState();
  }

  void _onItemTap(int index) {
    // if (_currentPage == index) {
    //   return;
    // }

    setState(() {
      _currentPage = index;
    });

    // switch (index) {
    //   case 0:
    //     Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    //     break;
    //   case 1:
    //     Navigator.of(context).pushReplacementNamed(ReadQuranPage.routeName);
    //     break;
    //   case 2:
    //     Navigator.of(context).pushReplacementNamed(MediaPage.routeName);
    //     break;
    //   case 3:
    //     Navigator.of(context).pushReplacementNamed(AdhanScreen.routeName);
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: _onItemTap,
      selectedItemColor: atlanticGullColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.shifting,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: buttomNavigationIcon("assets/images/quran2.png"),
            label: 'Quran'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow), label: 'Media'),
        const BottomNavigationBarItem(icon: Icon(Icons.mosque), label: 'Adhan'),
      ],
    );
  }
}

Widget buttomNavigationIcon(String path) {
  return SizedBox(
    height: 30,
    width: 30,
    child: Image.asset(
      path,
      fit: BoxFit.contain,
    ),
  );
}

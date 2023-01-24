import 'package:flutter/material.dart';
import '../../Features/Adhan/UI/adhan_screen.dart';

import '../../Features/ListeningQuran/UI/pages/MediaPage/mediaPage.dart';
import '../../Features/Qibla/qibla.dart';
import '../../Features/readQuran/UI/page/ReadQuranPage/ReadQuranPage.dart';
import '../../Features/readQuran/UI/page/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case ReadQuranPage.routeName:
        return MaterialPageRoute(builder: ((context) => ReadQuranPage()));
      case HomePage.routeName:
        return MaterialPageRoute(builder: ((context) => HomePage()));
      case MediaPage.routeName:
        return MaterialPageRoute(builder: ((context) => MediaPage()));
      case AdhanScreen.routeName:
        return MaterialPageRoute(builder: ((context) => AdhanScreen()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: ((context) => Scaffold(
              appBar: AppBar(title: const Text("Error Route")),
            )));
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/Bookmark/provider/bookmark_management_provider.dart';
import 'package:quran_twekl_app/Features/Bookmark/repository/bookmark_localsource.dart';
import 'package:quran_twekl_app/Features/Bookmark/repository/bookmark_repository.dart';
import 'Features/readQuran/UI/widget/custom_bottom_navigation_home.dart';
import 'core/route/routes.dart';
import 'Features/readQuran/providers/providers.dart';
import 'core/sizeConfig/textTheme.dart';
import 'core/sqflite_database/db_helper.dart';
import 'materialColor/material_color_generator.dart';
import 'materialColor/pallete.dart';
import 'Features/readQuran/UI/bloc/ReadQuranBloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Features/readQuran/UI/page/home_page.dart';
import "injection.dart" as co;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final _bookmarkRepository =
    BookmarkRepositoryImp(bookmarkLocalSource: BookmarkLocalSource());
final bookmarkManagementNotifier =
    BookmarkManagementNotifier(repository: _bookmarkRepository);

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  co.init();
  await bookmarkManagementNotifier.initialize(_bookmarkRepository);
  DBhelper db = DBhelper();
  try {
    await db.init();
    // ignore: empty_catches
  } on FileSystemException catch (e) {
    print(e.message);
  }

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final _locale = ref.watch(languageProvider).getLocale;
    return BlocProvider(
      create: (context) => co.sl<ReadQuranBloc>(),
      child: MaterialApp(
        restorationScopeId: "root",
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ""),
          Locale('fa', "")
        ],
        title: 'Flutter Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: generateMaterialColor(pallete.primaryColor),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: pallete.secondaryColor,
            ),
            textTheme: getTextTheme(_locale.languageCode)),
        home: HomePage(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

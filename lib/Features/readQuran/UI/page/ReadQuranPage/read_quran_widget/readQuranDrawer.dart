import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';
import 'fontSizeSelection.dart';

class ReadQuranDrawer extends StatefulWidget {
  @override
  State<ReadQuranDrawer> createState() => _ReadQuranDrawerState();
}

class _ReadQuranDrawerState extends State<ReadQuranDrawer> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(onListen);
    super.initState();
  }

  void onListen() {
    // print(_scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BlocProvider.of<ReadQuranBloc>(context, listen: false)
    //       .add(AllSurahEvent());
    // });
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(AppLocalizations.of(context).fontsize,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16)),
        ),
        FontSizeSelection(),
        const Expanded(
          child: SelectionSurahListHome(),
        )
      ])),
    );
  }
}

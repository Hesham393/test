import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'surahItemIndexing.dart';
import '../../../../../providers/providers.dart';

class SurahIndexingController extends ConsumerStatefulWidget {
  const SurahIndexingController({
    Key key,
  }) : super(key: key);

  ConsumerState<SurahIndexingController> createState() =>
      _SurahIndexingControllerState();
}

class _SurahIndexingControllerState
    extends ConsumerState<SurahIndexingController> {
  ItemScrollController _controller;
  @override
  void initState() {
    _controller = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(allSurahProvider);
    final surahNumber = ref.watch(SelectedSurahIndexProvider);

    _data.whenData(
        (value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (Scaffold.of(context).isDrawerOpen && _controller != null) {
                _controller.jumpTo(
                    index: surahNumber == 0 ? surahNumber : surahNumber - 1);
              }
            }));

    return _data.when(
        data: (data) {
          return ScrollablePositionedList.builder(
              itemScrollController: _controller,
              key: const PageStorageKey<String>("Selected_Surah"),
              itemBuilder: (context, index) => SurahItemIndexing(
                    surah: data[index],
                  ),
              itemCount: data.length);
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const SizedBox());
  }
}

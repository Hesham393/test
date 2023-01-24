import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../providers/providers.dart';
import 'juz_selection_item.dart';

class JuzSelection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      key: PageStorageKey<String>("selected_juz"),
      itemBuilder: (context, index) {
        final juzInfo =
            ref.read(juzInformationProvider).getJuzInfo((index + 1));
        return juzSelectionItem(juz: juzInfo);
      },
      itemCount: 30,
    );
  }
}

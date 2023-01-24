import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../Providers/providers.dart';
import '../../../../../../core/responsiveness/responsive.dart';

import 'QariItem.dart';

class qariSelectionList extends ConsumerWidget {
  qariSelectionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(getAllQariProvider);
    return data.when(
      data: (data) => 
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => QariItem(qari: data[index]),
                  childCount: data.length)),
        ),
      
      error: (error, stackTrace) => const SliverToBoxAdapter(),
      loading: () => const SliverToBoxAdapter(),
    );
  }
}

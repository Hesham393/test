import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/ReadQuranPage.dart';
import 'package:quran_twekl_app/Features/readQuran/providers/providers.dart';

class ScrollToHideWidget extends ConsumerWidget {
  final Widget child;
  final Duration duration;

  const ScrollToHideWidget(
      {Key key,
      @required this.child,
      this.duration = const Duration(milliseconds: 250)})
      : super(key: key);

  void listen(ScrollDirection direction, WidgetRef ref) {
    if (direction == ScrollDirection.forward) {
      show(ref);
    } else if (direction == ScrollDirection.reverse) {
      hide(ref);
    }
  }

  void show(WidgetRef ref) {
    // if (!_isVisible) {
    //    _isVisible = true;

    // }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(readQuranControllerFlag.notifier).state = true;
    });
  }

  void hide(WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(readQuranControllerFlag.notifier).state = false;
    });

    // if (_isVisible) {
    //   _isVisible = false;
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scroll_direction = ref.watch(scrollDirection);
    final bottomNavigationIndex = ref.watch(bottomNavigationIndexProvider);

    listen(scroll_direction, ref);
    return AnimatedContainer(
      height: bottomNavigationIndex != 1 ? kBottomNavigationBarHeight : 0,
      duration: duration,
      child: SingleChildScrollView(child: child),
    );
  }
}

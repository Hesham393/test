import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../providers/providers.dart';

class FontSizeSelection extends ConsumerWidget {
  const FontSizeSelection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final fontSize = ref.watch(quranFontSize);
    return Slider.adaptive(
      value: fontSize,
      onChanged: ((val) => ref.read(quranFontSize.notifier).state = val),
      label: "$fontSize",
      divisions: 14,
      min: 14,
      max: 28,
    );
  }
}

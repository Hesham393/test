import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/readQuran/providers/scrollspeedProvider.dart';
import 'package:quran_twekl_app/materialColor/pallete.dart';

import '../../../../../../core/sizeConfig/theme_configuration.dart';

class ScrollSpeeds {
  static const String slow = 'Slow';
  static const String normal = 'Normal';
  static const String fast = 'Fast';

  static int getDurationOfSpeed(String speed) {
    switch (speed) {
      case ScrollSpeeds.slow:
        return 240;
      case ScrollSpeeds.normal:
        return 130;
      case ScrollSpeeds.fast:
        return 100;
      default:
        return 130;
    }
  }
}

class selectScrollSpeedWT extends ConsumerStatefulWidget {
  @override
  ConsumerState<selectScrollSpeedWT> createState() =>
      _selectScrollSpeedWTState();
}

class _selectScrollSpeedWTState extends ConsumerState<selectScrollSpeedWT> {
  String dropDownValue;

  final List<String> items = [
    ScrollSpeeds.slow,
    ScrollSpeeds.normal,
    ScrollSpeeds.fast
  ];

  @override
  void initState() {
    // TODO: implement initState
    dropDownValue = items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeConfig().init(context);
    final textStyle = ThemeConfig.generalHeadline;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: pallete.secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: DropdownButton<String>(
            isDense: true,
            style: textStyle.copyWith(color: Colors.white, fontSize: 17),
            iconSize: 20,
            borderRadius: BorderRadius.circular(5),
            dropdownColor: pallete.secondaryColor,
            // icon: const Icon(Icons.speed),
            value: dropDownValue,
            items: items
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: textStyle.copyWith(fontSize: 13,color: Colors.white))))
                .toList(),
            onChanged: ((value) {
              ref.read(scrollSpeedProvider.notifier).state = value;
              setState(() {
                dropDownValue = value;
              });
            })),
      ),
    );
  }
}

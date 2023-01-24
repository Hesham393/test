import 'package:flutter/material.dart';

class QuranComImage extends StatelessWidget {
  const QuranComImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Image.asset(
          "assets/images/quran.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

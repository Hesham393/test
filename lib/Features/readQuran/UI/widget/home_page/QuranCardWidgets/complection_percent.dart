import 'package:flutter/material.dart';

class CompletionPercent extends StatelessWidget {
  const CompletionPercent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 8,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color.fromARGB(255, 197, 195, 195),
          ),
        ),
        Container(
          width: 30,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xFF7fd7dc),
          ),
        )
      ],
    );
  }
}

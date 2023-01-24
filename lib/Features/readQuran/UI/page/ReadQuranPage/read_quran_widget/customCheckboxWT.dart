import 'package:flutter/material.dart';

class CustomCheckboxWT extends StatelessWidget {
  final String title;
  final bool value;
  final Function onCheckboxChanged;
  const CustomCheckboxWT({
    @required this.onCheckboxChanged,
    @required this.title,
    @required this.value,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Checkbox(
          value: value,
          onChanged: (val) {
            onCheckboxChanged(val, title);
          },
        ),
      ],
    );
  }
}
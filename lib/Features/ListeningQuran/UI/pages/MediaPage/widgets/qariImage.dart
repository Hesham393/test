import 'package:flutter/material.dart';

class qariImage extends StatelessWidget {
  static const qariImageTag = "QariImage";
  final String imagePath;
  final bool isSelected;
  const qariImage({
    @required this.imagePath,
    this.isSelected = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected == true
        ? Hero(
            tag: qariImageTag,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black38,
              backgroundImage: AssetImage(imagePath),
            ),
          )
        : CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black38,
            backgroundImage: AssetImage(imagePath),
          );
  }
}

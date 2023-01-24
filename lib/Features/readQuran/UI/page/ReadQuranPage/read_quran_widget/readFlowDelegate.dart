import 'package:flutter/material.dart';

class ReadFlowDelegate extends FlowDelegate {
  ReadFlowDelegate({@required this.animation, this.ctx})
      : super(repaint: animation);
  final Animation<double> animation;
  final BuildContext ctx;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      double amount = -1 * i * animation.value * 45;

      double dy = MediaQuery.of(ctx).size.height - (kBottomNavigationBarHeight);
      double w = MediaQuery.of(ctx).size.width - 65;

      // double dx = (i * animation.value * w);
      double dx = w;
      dy += amount;
      // print("i :$i ,dx=$dx");
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0),
      );
      // context.paintChild(
      //   i,
      //   transform: Matrix4.translationValues(
      //     dx * animation.value,
      //     0,
      //     0,
      //   ),
      // );
    }
  }

  @override
  bool shouldRepaint(ReadFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

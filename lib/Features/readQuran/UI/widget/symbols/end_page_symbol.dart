import 'package:flutter/material.dart';

class EndPageSymbol extends StatelessWidget {
  final int pageNumber;
  EndPageSymbol({
    @required this.pageNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
            width: 230,
            height: 50,
            child: Image.asset("assets/images/endOfPageIcon.png",
                fit: BoxFit.contain)),
        Center(child: Text("$pageNumber"))
      ],
    );
  }
}

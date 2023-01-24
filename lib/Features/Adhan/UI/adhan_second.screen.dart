import 'package:flutter/material.dart';

class AdhanSecond extends StatelessWidget {
  final String payload;

    AdhanSecond({@required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: Text("$payload"),
      ),
    );
  }
}

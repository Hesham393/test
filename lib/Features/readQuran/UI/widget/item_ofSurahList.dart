import 'package:flutter/material.dart';

import '../../domain/entity/surah.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;

  SurahItem({@required this.surah});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        title: Text(surah.name),
        leading: CircleAvatar(child: Text("${surah.number}")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/qariModel.dart';

class SelectedQariNotifier with ChangeNotifier {
  Qari _qari = const Qari(
      id: "AbdulSamad_64kbps_QuranExplorer.Com",
      nation: "Egypt",
      name: "عبدالباسط عبدالصمد",
      englishName: "Abdul Samad",
      type: "Mortala",
      imagePath: "assets/images/Qari_Images/abdulbast.png");

  void setQari(Qari newQari) {
    _qari = newQari;
    notifyListeners();
  }

  Qari get getQari => _qari;
}

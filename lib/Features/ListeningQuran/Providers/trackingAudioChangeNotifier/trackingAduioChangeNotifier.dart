import 'package:flutter/material.dart';

class TrackingAudioNotifier with ChangeNotifier {
  int _surahNumber = 1;
  //int _surahLength = 0;
  int _ayahIndex = 0;

  void setSurahNumber(int number) {
    _surahNumber = number;
    notifyListeners();
  }

  void setAyahIndex(int index) {
    _ayahIndex = index;
    notifyListeners();
  }

  int get surahNumber => _surahNumber;
  int get ayahIndex => _ayahIndex;
}

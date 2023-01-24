import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomPlayList with ChangeNotifier {
  int _surahNumber;
  int _ayahIndex;
  List<Source> _audioSouces;
  bool _isPlay = false;
  String _selectedQari;
  CustomPlayList({int initialSurah = 0}) {
    _surahNumber = 1;
    _ayahIndex = 0;

    _audioSouces = <Source>[];
  }

  void setPlay() {
    _isPlay = true;
    notifyListeners();
  }

  void setQari(String qari) {
    _selectedQari = qari;
  }

  void setPause() {
    _isPlay = false;
    notifyListeners();
  }

  void clearAll() {
    _audioSouces.clear();
    notifyListeners();
  }

  bool isUrlSource() {
    if (_audioSouces.isNotEmpty) {
      if (_audioSouces[0] is UrlSource) {
        return true;
      }
      return false;
    }
    return false;
  }

  void addSource(Source source) {
    _audioSouces.add(source);
    notifyListeners();
  }

  void addAllSource(List<Source> sources) {
    for (var source in sources) {
      addSource(source);
    }
    notifyListeners();
  }

  void setSurahNumber(int number) {
    _surahNumber = number;
    notifyListeners();
  }

  void increaseAyahIndexByOne() {
    _ayahIndex++;
    notifyListeners();
  }

  void decreaseAyahIndexByOne() {
    _ayahIndex--;
    notifyListeners();
  }

  void setAyahIndex(int index) {
    _ayahIndex = index;
    notifyListeners();
  }

  List<Source> get sources => _audioSouces;

  bool get isPlay => _isPlay;
  int get length => _audioSouces.length ?? 0;
  int get surahNumber => _surahNumber;
  String get getQari => _selectedQari ?? "";
  int get ayahIndex => _ayahIndex;
}

import '../../../core/constant/pages_surah.dart';

class MapPageToSurah {
  String getEnglishSurah(int pageNumber) {
    return _getSurah(pageNumber, "english");
  }

  String getArabicSurah(int pageNumber) {
    return _getSurah(pageNumber, "arabic");
  }

  int getSurahNumber(String englishName) {
    int number = 1;
    mapPageToSurah.forEach((key, value) {
      if (value is List<Map<String, dynamic>>) {
        value.forEach((val) {
          if (val["english"] == englishName) {
            number = val["number"];
            return;
          }
        });
      } else {
        if (value["english"] == englishName) {
          number = value["number"];
          return;
        }
      }
    });
    return number;
  }

  String _getSurah(int pageNumber, String lanKey) {
    if (mapPageToSurah.containsKey(pageNumber)) {
      if (!isInSamePage(pageNumber)) {
        return mapPageToSurah[pageNumber][lanKey];
      }
      return mapPageToSurah[pageNumber][0][lanKey];
    }
    if (!isInSamePage(_findNext(pageNumber))) {
      return mapPageToSurah[_findNext(pageNumber)][lanKey];
    }
    return mapPageToSurah[_findNext(pageNumber)][0][lanKey];
  }

  int _findNext(int pageNumber) {
    for (int i = 0; i < mapPageToSurah.keys.length; i++) {
      if (pageNumber - mapPageToSurah.keys.toList()[i] < 0) {
        return mapPageToSurah.keys.toList()[i - 1];
      }
    }
  }

  int getPageNumberOfSurah(String englishName) {
    int _page = 1;
    mapPageToSurah.forEach((key, value) {
      if (value is List<Map<String, dynamic>>) {
        for (var val in value) {
          if (val["english"] == englishName) {
            _page = key;
            return;
          }
        }
      } else {
        if (value['english'] == englishName) {
          _page = key;
          return;
        }
      }
    });
    return _page;
  }

  static String _getSurahBySurahNo(int surahNumber, String lankey) {
    String surah = "";
    mapPageToSurah.forEach((key, value) {
      if (value is List<Map<String, dynamic>>) {
        for (var val in value) {
          if (val["number"] == surahNumber) {
            surah = val[lankey];
            return;
          }
        }
      } else {
        if (value['number'] == surahNumber) {
          surah = value[lankey];
          return;
        }
      }
    });
    return surah;
  }

  static String getEnglishSurahBySurahNO(int surahNumber) =>
      _getSurahBySurahNo(surahNumber, "english");

  static String getAraciSurahBySurahNO(int surahNumber) =>
      _getSurahBySurahNo(surahNumber,"arabic");
}

bool isInSamePage(int pageNumber) {
  if (pageNumber == 587 || pageNumber == 591 || pageNumber >= 595) {
    return true;
  }
  return false;
}

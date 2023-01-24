import '../Models/juz.dart';

class JuzRepository {
  JuzInformation getJuzInfo(int juzNumber) {
    if (juzNumber >= 1 && juzNumber <= 30) {
      return JuzInformation.fromMap(
          juzNumber,
          _juz_data.keys.toList()[juzNumber - 1],
          _juz_data.values.toList()[juzNumber - 1]);
    }
    return null;
  }

  int getJuzByPage(int pageNumber) {
    if (pageNumber < 22) {
      return 1;
    } else if (pageNumber < 42) {
      return 2;
    } else if (pageNumber < 62) {
      return 3;
    } else if (pageNumber < 82) {
      return 4;
    } else if (pageNumber < 102) {
      return 5;
    } else if (pageNumber < 121) {
      return 6;
    } else if (pageNumber < 142) {
      return 7;
    } else if (pageNumber < 162) {
      return 8;
    } else if (pageNumber < 182) {
      return 9;
    } else if (pageNumber < 202) {
      return 10;
    } else if (pageNumber < 222) {
      return 11;
    } else if (pageNumber < 242) {
      return 12;
    } else if (pageNumber < 262) {
      return 13;
    } else if (pageNumber < 282) {
      return 14;
    } else if (pageNumber < 302) {
      return 15;
    } else if (pageNumber < 322) {
      return 16;
    } else if (pageNumber < 342) {
      return 17;
    } else if (pageNumber < 362) {
      return 18;
    } else if (pageNumber < 382) {
      return 19;
    } else if (pageNumber < 402) {
      return 20;
    } else if (pageNumber < 422) {
      return 21;
    } else if (pageNumber < 441) {
      return 22;
    } else if (pageNumber < 462) {
      return 23;
    } else if (pageNumber < 482) {
      return 24;
    } else if (pageNumber < 502) {
      return 25;
    } else if (pageNumber < 522) {
      return 26;
    } else if (pageNumber < 542) {
      return 27;
    } else if (pageNumber < 562) {
      return 28;
    } else if (pageNumber < 582) {
      return 29;
    } else {
      return 30;
    }
  }

  static const Map<int, dynamic> _juz_data = {
    1: {
      "startE": "Al-Faatiha 1",
      "endE": "Al-Baqara 141",
      "startA": "ٱلْفَاتِحَةِ ١",
      "endA": "البَقَرَةِ ١٤١"
    },
    22: {
      "startE": "Al-Baqara 142",
      "endE": "Al-Baqara 252",
      "startA": "البَقَرَةِ ١٤٢",
      "endA": "البَقَرَةِ ٢٥٢"
    },
    42: {
      "startE": "Al-Baqara 253",
      "endE": "Aal-i-Imraan 92",
      "startA": "البَقَرَةِ ٢٥٣",
      "endA": "آلِ عِمۡرَانَ ٩٢",
    },
    62: {
      "startE": "Aal-i-Imraan 93",
      "endE": "An-Nisaa 23",
      "startA": "آلِ عِمۡرَانَ ٩٣",
      "endA": "النِّسَاءِ ٢٣"
    },
    82: {
      "startE": "An-Nisaa 24",
      "endE": "An-Nisaa 147",
      "startA": "النِّسَاءِ ٢٤",
      "endA": "النِّسَاءِ ١٤٧"
    },
    102: {
      "startE": "An-Nisaa 148",
      "endE": "Al-Maaida 82",
      "startA": "النِّسَاءِ ١٤٨",
      "endA": "المَائـِدَةِ ٨٢"
    },
    121: {
      "startE": "Al-Maaida 83",
      "endE": "Al-An'aam 110",
      "startA": "المَائـِدَةِ ٨٣",
      "endA": "الأَنۡعَامِ ١١٠"
    },
    142: {
      "startE": "Al-An'aam 111",
      "endE": "Al-A'raaf 87",
      "startA": "الأَنۡعَامِ ١١١",
      "endA": "الأَعۡرَافِ ٨٧"
    },
    162: {
      "startE": "Al-A'raaf 88",
      "endE": "Al-Anfaal 40",
      "startA": "الأَعۡرَافِ ٨٨",
      "endA": "الأَنفَالِ ٤٠"
    },
    182: {
      "startE": "Al-Anfaal 41",
      "endE": "At-Tawba 93",
      "startA": "الأَنفَالِ ٤١",
      "endA": "التَّوۡبَةِ ٩٣"
    },
    202: {
      "startE": "At-Tawba 94",
      "endE": "Hud 5",
      "startA": "التَّوۡبَةِ ٩٤",
      "endA": "هُودٍ ٥"
    },
    222: {
      "startE": "Hud 6",
      "endE": "Yusuf 52",
      "startA": "هُودٍ ٦",
      "endA": "يُوسُفَ ٥٢"
    },
    242: {
      "startE": "Yusuf 53",
      "endE": "Al-Hijr 1",
      "startA": "يُوسُفَ ٥٣",
      "endA": "الحِجۡرِ ١"
    },
    262: {
      "startE": "Al-Hijr 2",
      "endE": "An-Nahl 128",
      "startA": "الحِجۡرِ ٢",
      "endA": "النَّحۡلِ ١٢٨"
    },
    282: {
      "startE": "Al-Israa 1",
      "endE": "Al-Kahf 74",
      "startA": "الإِسۡرَاءِ ١",
      "endA": "الكَهۡفِ ٧٤"
    },
    302: {
      "startE": "Al-Kahf 75",
      "endE": "Taa-Haa 135",
      "startA": "الكَهۡفِ ٧٥",
      "endA": "طه ١٣٥"
    },
    322: {
      "startE": "Al-Anbiyaa 1",
      "endE": "Al-Hajj 78",
      "startA": "الأَنبِيَاءِ ١",
      "endA": "الحَجِّ ٧٨"
    },
    342: {
      "startE": "Al-Muminoon 1",
      "endE": "Al-Furqaan 20",
      "startA": "المُؤۡمِنُونَ ١",
      "endA": "الفُرۡقَانِ ٢٠"
    },
    362: {
      "startE": "Al-Furqaan 21",
      "endE": "An-Naml 59",
      "startA": "الفُرۡقَانِ ٢١",
      "endA": "النَّمۡلِ ٥٩"
    },
    382: {
      "startE": "An-Naml 60",
      "endE": "Al-Ankaboot 44",
      "startA": "النَّمۡلِ ٦٠",
      "endA": "العَنكَبُوتِ ٤٤"
    },
    401: {
      "startE": "Al-Ankaboot 45",
      "endE": "Al-Ahzaab 30",
      "startA": "العَنكَبُوتِ ٤٥",
      "endA": "الأَحۡزَابِ ٣٠"
    },
    422: {
      "startE": "Al-Ahzaab 31",
      "endE": "Yaseen 21",
      "startA": "الأَحۡزَابِ ٣١",
      "endA": "يسٓ ٢١"
    },
    441: {
      "startE": "Yaseen 22",
      "endE": "Az-Zumar 31",
      "startA": "يسٓ ٢٢",
      "endA": "الزُّمَرِ ٣١"
    },
    462: {
      "startE": "Az-Zumar 32",
      "endE": "Fussilat 46",
      "startA": "الزُّمَرِ ٣٢",
      "endA": "فُصِّلَتۡ ٤٦"
    },
    482: {
      "startE": "Fussilat 47",
      "endE": "Al-Jaathiya 37",
      "startA": "فُصِّلَتۡ ٤٧",
      "endA": "الجَاثِيَةِ ٣٧"
    },
    502: {
      "startE": "Al-Ahqaf 1",
      "endE": "Adh-Dhaariyat 30",
      "startA": "الأَحۡقَافِ ١",
      "endA": "الذَّارِيَاتِ ٣٠"
    },
    522: {
      "startE": "Adh-Dhaariyat 31",
      "endE": "Al-Hadid 29",
      "startA": "الذَّارِيَاتِ ٣١",
      "endA": "الحَدِيدِ ٢٩"
    },
    542: {
      "startE": "Al-Mujaadila 1",
      "endE": "At-Tahrim 12",
      "startA": "المُجَادلَةِ ١",
      "endA": "التَّحۡرِيمِ ١٢"
    },
    562: {
      "startE": "Al-Mulk 1",
      "endE": "Al-Mursalaat 50",
      "startA": "المُلۡكِ ١",
      "endA": "المُرۡسَلَاتِ ٥٠"
    },
    582: {
      "startE": "An-Naba 1",
      "endE": "At-An-Naas ٦",
      "startA": "النَّبَإِ ١",
      "endA": "النَّاسِ ٦"
    },
  };
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/core/model/kurdish_translation_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/core/sqflite_database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String api_url = "https://cdn.islamic.network/quran/audio/64";
const String api_text = "http://api.alquran.cloud/v1/surah";
const String k_api =
    "https://quranenc.com/api/v1/translation/sura/kurdish_bamoki";
String getUrl_AudioRequest({@required int ayah, @required String qari}) {
  String url = "$api_url/$qari/$ayah.mp3";
  return url;
}

void main() {
  group("httpRequest", () {
    //  File file = File("assets/audio/test.mpga");

    // test("should return file from api", () async {
    //   final response = await http.get(
    //     Uri.parse(url),
    //     headers: {"Content-Type": "application/json"},
    //   );

    //   if (response.statusCode == 200) {
    //     if (response.contentLength == 0) {
    //     } else {
    //       file.writeAsBytes(response.bodyBytes);
    //     }
    //   }
    // });

    test("get multiple file", () async {
      List<int> listId = [1, 6235, 6236, 34, 87, 999, 100, 77, 66, 99];
    });
  });
}

// Future<void> httpGetListOfAudio(List<int> listId) async {
//   for (var id in listId) {
//     final data =
//         await getFile(getUrl_AudioRequest(ayah: id, qari: "ar.alafasy"));
//     if (data == null) {
//       return;
//     }
//     final audioAyah = AudioAyahDB(audioBytes: data, ayah: id, qari: "ar.alafasy");

//   }
// }

Future<void> httpgetAyahsOfSurah(int surah, DBhelper db) async {
  final response = await http.get(Uri.parse("${api_text}/$surah"));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final listAyahModel =
        AyahModel.getListOfAyahModel(json["data"]["ayahs"], surah);
    for (var ayahModel in listAyahModel) {
      print(ayahModel);
      await db.insertAyah(ayahModel);
    }
  }
}

Future<void> httpGetKrAyahsOfSurah(int surah, DBhelper db) async {
  final response = await http.get(Uri.parse("${k_api}/$surah"));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final listAyahModel =
        kurdishTranslationModel.getListOfAyahModel(json["result"]);
    for (var ayahModel in listAyahModel) {
      await db.insertKrTranslation(ayahModel);
    }
  }
}

Future<void> httpGetDownloadSurah(int surah, DBhelper db) async {
  final response = await http.get(Uri.parse("${api_text}/$surah"));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final surah = SurahModel.fromJson(json["data"]);
    print(surah);
    await db.insertSurah(surah);
  }
}

class Received {
  static int count = 0;
  static int numberAyah = 1;
}

void downloadProgress(int received, int total) {
  if ((received / total * 100).toInt() == 100) {
    Received.count++;
    print(
        (Received.count / Received.numberAyah * 100).toStringAsFixed(0) + "%");
  }
}

Future<Uint8List> getFile(String url) async {
  Dio dio = Dio();

  final response = await dio.get(url,
      onReceiveProgress: downloadProgress,
      options: Options(responseType: ResponseType.bytes));

  // final response=await http.get(
  //   Uri.parse(url),
  //   headers: {"Content-Type": "application/json"},
  // );
  if (response.statusCode == 200) {
    return response.data;
  }
  return null;
}

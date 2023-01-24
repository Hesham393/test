import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../Features/readQuran/dataSource/model/ayah_model.dart';
import '../../Features/readQuran/dataSource/model/surah_model.dart';
import '../sqflite_database/db_helper.dart';

const String api_text = "http://api.alquran.cloud/v1/surah";
const String api_url = "https://cdn.islamic.network/quran/audio/64";

class httpService {
  static String getUrl_AudioRequest(
      {@required int ayah, @required String qari}) {
    String url = "$api_url/$qari/$ayah.mp3";
    return url;
  }

  static Future<void> httpGetDownloadSurah(int surah, DBhelper db) async {
    final response = await http.get(Uri.parse("${api_text}/$surah"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final surah = SurahModel.fromJson(json["data"]);
      await db.insertSurah(surah);
    }
  }

  static Future<void> httpGetListOfAudio(List<int> listId) async {
    for (var id in listId) {
      final data =
          await getFile(getUrl_AudioRequest(ayah: id, qari: "ar.alafasy"));
      if (data == null) {
        return;
      }
      // final audioAyah =
      //     AudioAyahDB(audioBytes: data, ayah: id, qari: "ar.alafasy");
      final app_path = await getApplicationSupportDirectory();
      final file_path = await getPath(
          join(app_path.path, "QuranAudios", "Surah1", "ar.alafasy"));
      File file = File("${file_path.path}/audio$id.mpga");
      print(data);
      //  file.writeAsBytesSync(data);
      await file.writeAsBytes(data);
    }
  }

  static Future<Directory> getPath(String file_path) async {
    final directory = Directory(file_path);

    if ((await directory.exists())) {
      return directory;
    }

    return await directory.create(recursive: true);
  }

  static Future<Uint8List> getFile(String url) async {
    // Dio dio = Dio();

    // final response = await dio.get(url,
    //     onReceiveProgress: downloadProgress,
    //     options: Options(responseType: ResponseType.bytes));

    final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }

  static void downloadProgress(int received, int total) {
    if ((received / total * 100).toInt() == 100) {
      Received.count++;
      print((Received.count / Received.numberAyah * 100).toStringAsFixed(0) +
          "%");
    }
  }

  static Future<void> httpgetAyahsOfSurah(int surah, DBhelper db) async {
    final response = await http.get(Uri.parse("${api_text}/$surah"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final listAyahModel =
          AyahModel.getListOfAyahModel(json["data"]["ayahs"], surah);
      print(listAyahModel);
      for (var ayahModel in listAyahModel) {
        print(ayahModel);
        await db.insertAyah(ayahModel);
      }
    }
  }
}

class Received {
  static int count = 0;
  static int numberAyah = 1;
}

import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:quran_twekl_app/Features/ListeningQuran/models/ayahAudio.dart';
import 'package:quran_twekl_app/Features/ListeningQuran/models/qariModel.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/surah.dart';
import 'package:quran_twekl_app/core/httpRequest/httpClass.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/ayah_model.dart';
import 'package:quran_twekl_app/Features/readQuran/dataSource/model/surah_model.dart';
import 'package:quran_twekl_app/core/sqflite_database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../fixture/fixture_reader.dart';
import "../../../lib/core/model/kurdish_translation_model.dart";
import '../http_request/request_http_test.dart';

class TestDatabase {
  static Database db;
}

void main() async {
  sqfliteFfiInit();

  group("DBHelper", () {
    // final surahModel =
    //     SurahModel.fromJson(jsonDecode(fixture("json_surah.json")));
    Uint8List bytes;
    DBhelper dbHelper;

    //final ayahModel = AyahModel.fromJson(jsonDecode(fixture("ayahData.json")));
    // https://www.everyayah.com/data/Ibrahim_Akhdar_64kbps/001001.mp3
    final qariModel = const Qari(
        id: "Ibrahim_Akhdar_64kbps",
        nation: "Saudi",
        name: "إبراهيم الأخضر",
        englishName: "Ibrahim Akhdar",
        type: "Moratla",
        imagePath: "assets/images/Qari_Images/Ibrahim_Akhdar.png");

    setUpAll(() async {
      //await databaseFactoryFfi.deleteDatabase("dev/sda1/database_test/testDB2.db");
      TestDatabase.db = await databaseFactoryFfi.openDatabase(
          '/media/hesham/Data/database_test/testDB2.db',
          options: OpenDatabaseOptions(version: 1));
      dbHelper = DBhelper(db: TestDatabase.db);
      //

      await TestDatabase.db.execute('PRAGMA foreign_keys = ON');

      // int SurahNumber = 2;

      // await dbHelper.deleteTable(DBTables.audioAyah);
      // await dbHelper.init();

      // await httpGetDownloadSurah(SurahNumber, dbHelper);

      // await httpService.httpgetAyahsOfSurah(SurahNumber, dbHelper);

      // await TestDatabase.db.delete(DBTables.surah,
      //     where: "${SurahFields.number}=?", whereArgs: ["2"]);
    });

    // test('should insert kurdish translation', () async {
    //   await httpGetKrAyahsOfSurah(1, dbHelper!);
    // });
    //ar.abdulsamad

//AbdulSamad_64kbps_QuranExplorer.Com
    // test('should updage qari table', () async {
    //   await dbHelper.updateQariIdentification("Abdurrahmaan_As-Sudais_192kbps",
    //       conditionValue: "ar.abdurrahmaansudais");
    // });

    // test("getCountVersesOfSurah", () async {
    //   final data = await dbHelper.getCountVersesOfPage(518);
    //   print(data);
    // });

    //  test('should return kurdish translation', () async {
    //   final data=await dbHelper!.getKrAyahsOfSurah(1);
    //    for(var kr in data){
    //     print(kr.text);
    //    }
    // });

    // test("getFirstPageOfSurah", ()async{
    //        final data=await dbHelper.getFirstNumberPageOfSurah(50);
    //        print(data);
    // });

    // test("download ayahs of Surah", () async {
    //   await httpService.httpgetAyahsOfSurah(2, dbHelper);
    // });

    // test('database creation', () async {
    //   expect(await dbHelper.mydb!.getVersion(), 0);
    // });

    // test('database should download from http  surah', () async {
    //   //SqfliteFfiException
    //   await httpGetDownloadSurah(1, dbHelper);
    // });

    // test('database should get all surah', () async {
    //   final data = await dbHelper.getAllSurah();
    //   for (var surah in data) {
    //     print(surah);
    //   }
    // });

    // test('database should save ayah', () async {
    //   try {
    //     final result = await dbHelper!.insertAyah(ayahModel);
    //   } catch (e) {
    //     print(e);
    //   }
    // });

    // test('database should get ayahs of specific surah', () async {
    //   final ayahs = await dbHelper.getAyahsOfSurah(46);
    //   print(ayahs.length);
    //   for (var ayah in ayahs) {
    //     print(ayah);
    //   }
    // });

    //insert qari

    // test('database should save qari', () async {
    //   try {
    //     await dbHelper.insertQari(qariModel);
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });

    // test('database should get qari', () async {
    //   final qari = await dbHelper.getAllQari();
    //   qari.forEach((qar) {
    //     print(qar);
    //   });
    // });

    //insert Audio Ayah

    // test('database should save audio', () async {
    //   //SqfliteFfiException
    //   final audioAyah = AudioAyah(
    //       filePath: "app/test.mp3", qari: "ar.abdurrahmaansudais", ayah: 88000);
    //   try {
    //     // final res = await getFile("$api_url/ar.alafasy/6236.mp3");
    //     // bytes = res;
    //     // final audioAyahModel =
    //     //     AudioAyahDB(audioBytes: bytes, ayah: 6236, qari: "ar.alafasy");
    //     await dbHelper.insertAudio(audioAyah);
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });

    // test("should delete the audio ayah ", () async {
    //   await dbHelper.deleteAudio(88000);
    // });

    // test("should return list of ayah from http get request", () async {
    //   final response = await httpgetAyahsOfSurah(1, dbHelper!);
    // });

    // test("download audio ayahs of surah with http get request ", () async {
    //   final listId = await dbHelper!.getAyahsIdOfSurah(1);
    //   await httpGetListOfAudio(listId, dbHelper!);
    // });

    // test("should get from database audioAyah of surah", () async {
    //   final list = await dbHelper!.getAudioAyahsOfSurah(1, "ar.alafasy");
    //   if (list != null) {
    //     for (var audio in list) {
    //       print(audio.audioFile.path);
    //     }
    //   } else {
    //     print(null);
    //   }
    // });

    //   test("should get Ayahs of surah", () async {
    //     final list = await dbHelper!.getAyahsOfSurah(1);
    //     if (list != null) {
    //       for (var ayah in list) {
    //         print(ayah);
    //       }
    //     } else {
    //       print(null);
    //     }
    //   });
  });
}

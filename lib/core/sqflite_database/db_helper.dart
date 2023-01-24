import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../Features/ListeningQuran/models/ayahAudio.dart';
import '../../Features/ListeningQuran/models/qariModel.dart';
import '../../Features/readQuran/dataSource/model/ayah_model.dart';
import '../../Features/readQuran/dataSource/model/surah_model.dart';
import '../../Features/readQuran/domain/entity/ayah.dart';
import '../../Features/readQuran/domain/entity/surah.dart';
import '../entity/english_translation.dart';
import '../entity/kurdish_Translation.dart';
import '../model/kurdish_translation_model.dart';

class DBhelper extends Sqflite {
  final String _db_name = "quran.db";
  Database _mydb;
  DBhelper({Database db}) {
    this._mydb = db;
  }

  Future<void> init() async {
    // await _onCreate(_mydb);
    //await _onUpgrade(_mydb, 1, 2);
    _copyDatabase();
  }

  Future<void> _copyDatabase() async {
    // try{
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _db_name);
    print("path : $path");
    final File file = File(path);

    if (!file.existsSync()) {
      ByteData data =
          await rootBundle.load(join('assets', 'database', 'testDB2.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await file.writeAsBytes(bytes, flush: true);
      print('database successfully copied to $path');
    } else {
      print('database already exist');
      print(file.path);
    }
    // } on FileSystemException catch (e) {
    //   print("message :${e.message}");
    //   print("oserror : ${e.osError}");
    // }
  }

  Future<void> _onCreate(Database db) async {
    //create surah table
    await db.execute(DBQueries.sqlQuerySurah);
    //initialize tables[juz,manzil,page,ruku,hizquarter]
    await initialize_table(db);

    //create ayah table
    await db.execute(DBQueries.sqlQuery_ayah);

    //create qari table
    await db.execute(DBQueries.sqlQueryQari);

    //create AudioAyah table
    await db.execute(DBQueries.sqlQueryAudioAyah);

    //create KurdishTranslatioin Table

    //await db.execute(DBQueries.sqlQueryKurdishTranslation);

    //create EnglishTranslatioin Table

    //  await db.execute(DBQueries.sqlQueryEnglishTranslation);

    await initialize_data();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1) {
      //create KurdishTranslatioin Table

      // await db.execute(DBQueries.sqlQueryKurdishTranslation);

      //await _deleteTable(DBTables.audioAyah);
      // await _deleteTable(DBTables.qari);

      //  await db.execute(DBQueries.sqlQueryQari);
      await db.execute(DBQueries.sqlQueryAudioAyah);
      print("upgraded");

      //create EnglishTranslatioin Table

      // await db.execute(DBQueries.sqlQueryEnglishTranslation);

      // await db.execute("DROP TABLE IF EXISTS ${DBTables.kurdishTranslation}");
      // await db.execute("DROP TABLE IF EXISTS ${DBTables.EnglishTranslation}");
    }
  }

  Future<Database> _getDatabase() async {
    if (_mydb != null) {
      return _mydb;
    }
    final dbPath = await getDatabasesPath();
    // final computer_path = '/media/hesham/Data/database_test';

    final db = openDatabase(
      join(dbPath, _db_name),
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async => _onCreate(db),
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  // --------------- kurdish Translation ----------------

  Future<void> insertKrTranslation(kurdishTranslationModel kurdishModel) async {
    final db = await _getDatabase();
    await db.insert(DBTables.kurdishTranslation, kurdishModel.toDB);
  }

  Future<void> updateQariIdentification(String value,
      {String conditionValue}) async {
    final db = await _getDatabase();
    await db.update(DBTables.qari, {QariFields.identifier: value},
        where: "${QariFields.identifier}=?", whereArgs: [conditionValue]);
  }

  Future<List<kurdishTranslationModel>> getKrAyahsOfSurah(int surah) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.kurdishTranslation,
        where: "${kurdishTranslationFields.surah}=?", whereArgs: ["$surah"]);
    return List<kurdishTranslationModel>.generate(
        data.length, (index) => kurdishTranslationModel.fromDB(data[index]));
  }

  // --------------- Audio Methods ----------------
  Future<void> insertAudio(AudioAyah audioAyah) async {
    final db = await _getDatabase();
    await db.insert(DBTables.audioAyah, audioAyah.toDB);
  }

  Future<List<AudioAyah>> getAudioAyahsOfSurah(
      int surahNumber, String qari) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.audioAyah,
        where: "${AudioAyahFields.qari}=? AND ${AudioAyahFields.surah}=?",
        whereArgs: ["$qari", "$surahNumber"]);

    return List<AudioAyah>.generate(
        data.length, (index) => AudioAyah.fromDB(data[index]));
  }

  Future<int> getAudioFileNumberOfSurah(int surahNumber, String qari) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.audioAyah,
        where: "${AudioAyahFields.qari}=? AND ${AudioAyahFields.surah}=?",
        whereArgs: ["$qari", "$surahNumber"]);
    return data.length;
  }

  Future<void> deleteAudio(int ayahId) async {
    final db = await _getDatabase();
    await db.delete(DBTables.audioAyah,
        where: "${AudioAyahFields.ayah}=?", whereArgs: ["$ayahId"]);
  }

  // Future<AudioAyah?> getAudioAyah(int ayahNumber, int qariNumber) async {
  //   final db = await _getDatabase();
  //   final res = await db.query(DBTables.audioAyah,
  //       where: "${AudioAyahFields.ayah}=? and ${AudioAyahFields.qari}=? ",
  //       whereArgs: ["$ayahNumber", "$qariNumber"]);
  //   if (res.length == 0) {
  //     return null;
  //   }
  //   final audiofile = AudioAyahDB.fromDB(res[0]);

  //   return await audiofile.getAudioAyah(await getSurahIdByAyah(audiofile.ayah));
  // }

  // Future<List<AudioAyah>?> getAudioAyahsOfSurah(
  //     int surahNumber, String qari) async {
  //   final db = await _getDatabase();
  //   final listOfAyahId = await getAyahsIdOfSurah(surahNumber);
  //   List<AudioAyah> audioList = [];

  //   for (var ayah in listOfAyahId) {
  //     final res = await db.query(DBTables.audioAyah,
  //         where: "${AudioAyahFields.ayah}=? and ${AudioAyahFields.qari}=? ",
  //         whereArgs: ["$ayah", "$qari"]);
  //     if (res.length == 0) {
  //       return null;
  //     }
  //     final audiofile = AudioAyahDB.fromDB(res[0]);
  //     final ayahAudio =
  //         await audiofile.getAudioAyah(await getSurahIdByAyah(audiofile.ayah));
  //     audioList.add(ayahAudio!);
  //   }
  //   return audioList;
  // }

  // ------------- end ---------------------

  // ------------- qari methods ----------------

  Future<void> insertQari(Qari qari) async {
    final db = await _getDatabase();
    await db.insert(DBTables.qari, qari.toDB);
  }

  // Future<QariModel> getQari(String identifier) async {
  //   final db = await _getDatabase();
  //   final res = await db.query(DBTables.qari,
  //       where: "${QariFields.identifier}=?", whereArgs: ["$identifier"]);
  //   if (res.length == 0) {
  //     return null;
  //   }
  //   return QariModel.fromDB(res[0]);
  // }

  Future<List<Qari>> getAllQari() async {
    final _db = await _getDatabase();
    final data = await _db.query(DBTables.qari);
    return List<Qari>.generate(
        data.length, (index) => Qari.fromDB(data[index]));
  }

  // -------------- end ---------------

  //--------- surah methods---------------

  Future<int> insertSurah(SurahModel surah) async {
    final db = await _getDatabase();
    return await db.insert(DBTables.surah, surah.toJson);
  }

  Future<int> getFirstNumberPageOfSurah(int surahNumber) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah,
        where: "${AyahFields.surah}=?", whereArgs: ["$surahNumber"], limit: 1);
    return (data[0][AyahFields.page] as int);
  }

  Future<SurahModel> getSurah(int number) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.surah,
        where: "number=?", whereArgs: ["$number"], limit: 1);
    return SurahModel.fromJson(data[0]);
  }

  Future<int> getCountVersesOfSurah(int surahNumber) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.surah,
        columns: [SurahFields.numberOfAyahs],
        where: "${SurahFields.number}=?",
        whereArgs: ["$surahNumber"],
        limit: 1);
    return (data[0][SurahFields.numberOfAyahs] as int);
  }

  Future<int> getSurahIdByAyah(int ayahNumber) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah,
        columns: [AyahFields.surah],
        where: "${AyahFields.number}=?",
        whereArgs: ["$ayahNumber"]);
    if (data.length == 0) {
      return 0;
    }
    return data[0][AyahFields.surah] as int;
  }

  Future<List<SurahModel>> getAllSurah() async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.surah);

    return List<SurahModel>.generate(data.length, (i) {
      return SurahModel.fromJson(data[i]);
    });
  }

  Future<int> getCountVersesOfPage(int pageNumber) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah,
        columns: [AyahFields.number],
        where: "${AyahFields.page}=?",
        whereArgs: ["$pageNumber"]);
    return data.length;
  }

  //--------------- end  --------------

  // --------------- Ayah Methods --------------

  Future<int> insertAyah(AyahModel ayah) async {
    final db = await _getDatabase();
    return await db.insert(DBTables.ayah, ayah.toJson);
  }

  //list of ayah according to surah number
  Future<List<AyahModel>> getAyahsOfSurah(int surah) async {
    final db = await _getDatabase();
    final data =
        await db.query(DBTables.ayah, where: "surah=?", whereArgs: ["$surah"]);
    return List<AyahModel>.generate(data.length, (i) {
      return AyahModel.fromDB(data[i]);
    });
  }

  Future<List<int>> getAyahsIdOfSurah(int surah) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah,
        columns: [AyahFields.number], where: "surah=?", whereArgs: ["$surah"]);
    return List<int>.generate(data.length, (i) {
      return data[i][AyahFields.number] as int;
    });
  }

  // get single ayah
  Future<AyahModel> getAyah(int number) async {
    await _getDatabase().then((db) async {
      final data = await db
          .query(DBTables.ayah, where: "number=?", whereArgs: ["$number"]);
      if (data.length == 0) {
        return null;
      }
      return AyahModel.fromDB(data[0]);
    });
  }

  Future<List<AyahModel>> getAyahsOfPage(int pageNumber) async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah,
        where: "${AyahFields.page}=?", whereArgs: ["$pageNumber"]);
    return List<AyahModel>.generate(data.length, (index) {
      return AyahModel.fromDB(data[index]);
    });
  }

  Future<List<AyahModel>> getAllAyah() async {
    final db = await _getDatabase();
    final data = await db.query(DBTables.ayah);
    return List<AyahModel>.generate(data.length, (index) {
      return AyahModel.fromDB(data[index]);
    });
  }

  Future<void> closeDb() async {
    await _getDatabase().then((db) async => await db.close());
  }

  Future<void> deleteTable(String table) async {
    await _getDatabase()
        .then((db) async => await db.execute("DROP TABLE $table"));
  }

  //   --------- end -----------

  //initializing part

  Future<void> initialize_data() async {
    final db = await _getDatabase();
    //juz
    for (int i = 1; i <= 30; i++) {
      await db.insert(DBTables.juz, {"number": i});
    }
    //manzil
    for (int i = 1; i <= 7; i++) {
      await db.insert(DBTables.manzil, {"number": i});
    }

    //page
    for (int i = 1; i <= 604; i++) {
      await db.insert(DBTables.page, {"number": i});
    }
    //ruku
    for (int i = 1; i <= 556; i++) {
      await db.insert(DBTables.ruku, {"number": i});
    }

    //hizbQuarter
    for (int i = 1; i <= 240; i++) {
      await db.insert(DBTables.hizbQuarter, {"number": i});
    }
  }

  //initialize tables
  Future<void> initialize_table(Database mydb) async {
    const number_column = "(number INTEGER PRIMARY KEY)";
    //create juz table
    await mydb.execute("CREATE TABLE ${DBTables.juz} $number_column");

    //create manzil table with 7 record of manzil
    await mydb.execute("CREATE TABLE ${DBTables.manzil} $number_column");

    //create page table with 604 recode of page
    await mydb.execute("CREATE TABLE ${DBTables.page}$number_column");

    //create ruku table
    await mydb.execute("CREATE TABLE ${DBTables.ruku} $number_column");

    //create hizbQuarter table
    await mydb.execute("CREATE TABLE ${DBTables.hizbQuarter} $number_column");
  }
}

class DBTables {
  static const String surah = "Surah";
  static const String ayah = "Ayah";
  static const String juz = "Juz";
  static const String manzil = "Manzil";
  static const String page = "Page";
  static const String ruku = "Ruku";
  static const String hizbQuarter = "HizbQuarter";
  static const String qari = "QariTb";
  static const String audioAyah = "AudioAyah";
  static const String kurdishTranslation = "kurdishTranslation";
  static const String EnglishTranslation = "EnglishTranslation";
}

class DBQueries {
  static const String cascadeDeleteUpdate =
      "(number) ON DELETE CASCADE ON UPDATE CASCADE";
  static const String sqlQuery_ayah = "CREATE TABLE ${DBTables.ayah}"
      "(${AyahFields.number} INTEGER PRIMARY KEY,"
      "${AyahFields.text} TEXT,"
      "${AyahFields.surah} INTEGER,"
      "${AyahFields.numberInSurah} INTEGER,"
      "${AyahFields.juz} INTEGER,"
      "${AyahFields.manzil} INTEGER,"
      "${AyahFields.page} INTEGER,"
      "${AyahFields.ruku} INTEGER,"
      "${AyahFields.hizbQuarter} INTEGER,"
      "${AyahFields.sajda} INTEGER,"
      "FOREIGN KEY (${AyahFields.surah}) REFERENCES ${DBTables.surah} ${DBQueries.cascadeDeleteUpdate},"
      "FOREIGN KEY (${AyahFields.juz}) REFERENCES ${DBTables.juz} ${DBQueries.cascadeDeleteUpdate},"
      "FOREIGN KEY (${AyahFields.manzil}) REFERENCES ${DBTables.manzil} ${DBQueries.cascadeDeleteUpdate},"
      "FOREIGN KEY (${AyahFields.page}) REFERENCES ${DBTables.page} ${DBQueries.cascadeDeleteUpdate},"
      "FOREIGN KEY (${AyahFields.ruku}) REFERENCES ${DBTables.ruku} ${DBQueries.cascadeDeleteUpdate},"
      "FOREIGN KEY (${AyahFields.hizbQuarter}) REFERENCES ${DBTables.hizbQuarter} ${DBQueries.cascadeDeleteUpdate}"
      ")";
  static const String sqlQuerySurah = "CREATE TABLE ${DBTables.surah}("
      "${SurahFields.number} INTEGER PRIMARY KEY,"
      "${SurahFields.name} TEXT UNIQUE,"
      "${SurahFields.englishName} TEXT,"
      "${SurahFields.englishNameTranlation} TEXT,"
      "${SurahFields.revelationType} TEXT,"
      "${SurahFields.numberOfAyahs} INTEGER"
      ")";

  static const String sqlQueryQari = "CREATE TABLE ${DBTables.qari}("
      "${QariFields.identifier} TEXT PRIMARY KEY,"
      "${QariFields.nation} TEXT,"
      "${QariFields.name} TEXT,"
      "${QariFields.englishName} TEXT,"
      "${QariFields.type} TEXT,"
      "${QariFields.imagePath} TEXT"
      ")";

  static const String sqlQueryAudioAyah = "CREATE TABLE ${DBTables.audioAyah}("
      "${AudioAyahFields.ayah} INTEGER,"
      "${AudioAyahFields.surah} INTEGER,"
      "${AudioAyahFields.filePath} TEXT,"
      "${AudioAyahFields.qari} TEXT,"
      "PRIMARY KEY(${AudioAyahFields.ayah},${AudioAyahFields.qari},${AudioAyahFields.surah}),"
      "FOREIGN KEY (${AudioAyahFields.qari}) REFERENCES ${DBTables.qari} (${QariFields.identifier}),"
      "FOREIGN KEY (${AudioAyahFields.surah}) REFERENCES ${DBTables.surah} (${SurahFields.number})"
      ")";

  static const String sqlQueryKurdishTranslation =
      "CREATE TABLE ${DBTables.kurdishTranslation}("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "${kurdishTranslationFields.ayah} INTEGER,"
      "${kurdishTranslationFields.text} TEXT,"
      "${kurdishTranslationFields.translationType} TEXT,"
      "${kurdishTranslationFields.surah} INTEGER,"
      "FOREIGN KEY (${kurdishTranslationFields.ayah}) REFERENCES ${DBTables.ayah} (${AyahFields.number}) ON DELETE CASCADE ON UPDATE CASCADE,"
      "FOREIGN KEY (${kurdishTranslationFields.surah}) REFERENCES ${DBTables.surah} (${SurahFields.number}) ON DELETE CASCADE ON UPDATE CASCADE"
      ")";

  static const String sqlQueryEnglishTranslation =
      "CREATE TABLE ${DBTables.EnglishTranslation}("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "${EnglishTranslationFields.ayah} INTEGER,"
      "${EnglishTranslationFields.text} TEXT,"
      "${EnglishTranslationFields.surah} INTEGER,"
      "${EnglishTranslationFields.translationType} TEXT,"
      "FOREIGN KEY (${EnglishTranslationFields.ayah}) REFERENCES ${DBTables.ayah} (${AyahFields.number}) ON DELETE CASCADE ON UPDATE CASCADE"
      ")";
}

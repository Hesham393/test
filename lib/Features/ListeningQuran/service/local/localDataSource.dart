import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/audioFile.dart';
import '../../models/ayahAudio.dart';
import '../../models/qariModel.dart';
import 'package:path/path.dart';
import '../../../../core/sqflite_database/db_helper.dart';

abstract class LocalDataSource {
  Future<bool> isDownloaded(int surahNumber, String qari);
  Future<List<int>> getAyahsIdOfSurah(int surahNumber);
  Future<String> saveAudioFileOnDevice(AudioFile audioFile);
  // Future<Directory> createAudioFileDirectory(String qari);
  Future<void> saveAudioFileOnDB(AudioAyah audioAyah);
  Future<List<AudioAyah>> getAudioAyahsOfSurah(int surahNumber, String qari);
  Future<List<Qari>> getAllQari();
}

class LocalDataSourceImp extends LocalDataSource {
  final DBhelper dBhelper;

  LocalDataSourceImp({
    @required this.dBhelper,
  });

  @override
  Future<List<Qari>> getAllQari() async => await dBhelper.getAllQari();

  @override
  Future<List<int>> getAyahsIdOfSurah(int surahNumber) async =>
      await dBhelper.getAyahsIdOfSurah(surahNumber);

  @override
  Future<bool> isDownloaded(int surahNumber, String qari) async {
    final audioFilesLength =
        await dBhelper.getAudioFileNumberOfSurah(surahNumber, qari);
    // for performance u can make it constant request get count verses of surah
    final surahLength = await dBhelper.getCountVersesOfSurah(surahNumber);

    if (surahLength == audioFilesLength) {
      return true;
    }

    return false;
  }

  @override
  Future<void> saveAudioFileOnDB(AudioAyah audioAyah) async {
    await dBhelper.insertAudio(audioAyah);
  }

  @override
  Future<String> saveAudioFileOnDevice(audioFile) async {
    final dir = await _createAudioFileDirectory(audioFile.qari);
    File file = File(join(dir.path, "${audioFile.ayah}.wav"));
    await file.writeAsBytes(audioFile.bytes, flush: true);
    return file.path;
  }

  Future<Directory> _createAudioFileDirectory(String qari) async {
    final deviceSupportPath = await getApplicationSupportDirectory();
    final dir = Directory(join(deviceSupportPath.path, "AudioFiles", qari));
    if (dir.existsSync()) {
      return dir;
    }
    return await dir.create(recursive: true);
  }

  @override
  Future<List<AudioAyah>> getAudioAyahsOfSurah(
          int surahNumber, String qari) async =>
      await dBhelper.getAudioAyahsOfSurah(surahNumber, qari);
}

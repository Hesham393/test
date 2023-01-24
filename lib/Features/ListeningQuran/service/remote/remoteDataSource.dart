import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/audioFile.dart';
import '../../../../core/error/error.dart';

import '../downloadStatus/dowloadStatus.dart';

abstract class RemoteDataSource {
  Future<List<AudioFile>> downloadAudioFilesOfSurah(int surahNumber,
      List<int> ayahIdOfSurah, String qari, DownloadProgress downloadProgress);

  List<String> getSurahUrls(
      int surahNumber, List<int> ayahIdOfSurah, String qari);
}

class RemoteDataSourceImp extends RemoteDataSource {
  // static const String _audioEndPoint =
  //     "https://cdn.islamic.network/quran/audio/64";
  static const String _audioEndPoint = "https://www.everyayah.com/data";
  //https://www.everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/001001.mp3
  //https://www.everyayah.com/data/AbdulSamad_64kbps_QuranExplorer.Com/103001.mp3
  final _headers = {
    "content-type": "application/json",
    "Connection": "keep-alive"
  };
  final http.Client httpClient;
  RemoteDataSourceImp({@required this.httpClient});

  @override
  Future<List<AudioFile>> downloadAudioFilesOfSurah(
      int surahNumber,
      List<int> ayahIdOfSurah,
      String qari,
      DownloadProgress downloadProgress) async {
    List<AudioFile> list = [];
    try {
      // int count = 0;
      //if you want to inclue bismilah you have to loop till the length+1 of list
      //we're going to use index for everyAyah api
      //we're goint to use ayah number([1-6236]) for cdn.islamic.network
      for (int i = 0; i <= ayahIdOfSurah.length; i++) {
        list.add(await _downloadSingleAudioFile(
            surahNumber, ayahIdOfSurah[0], i, qari, downloadProgress));
        // count++;
      }
      return list;
    } catch (e) {
      print("${e.runtimeType.toString()} ......................0000");
      throw ConnectionException();
    }
  }

  Future<AudioFile> _downloadSingleAudioFile(int surahNumber, int ayah,
      int index, String qari, DownloadProgress downloadProgress) async {
    //print(ayah);
    String ayahNumber = getNumberOfAyahOrSurah(index);
    String surah = getNumberOfAyahOrSurah(surahNumber);
    final request = http.Request(
      "GET",
      Uri.parse("$_audioEndPoint/$qari/$surah$ayahNumber.mp3"),
    );
    request.headers.addAll(_headers);
    final streamResponse = await httpClient.send(request);
    final contentLength = streamResponse.contentLength;

    final bytes = <int>[];
    Completer<AudioFile> completer = Completer();
    streamResponse.stream.listen(
      (newBytes) {
        if (contentLength != null && newBytes != null) {
          bytes.addAll(newBytes);
          if (bytes.length == contentLength) {
            downloadProgress.increaseReceivedData();
          }
        }
      },
      onError: (e) {},
      cancelOnError: true,
    ).onDone(
      () {
        // print("on done");
        completer.complete(AudioFile(bytes: bytes, ayah: ayah, qari: qari));
      },
    );
    return await completer.future;
  }

  String getNumberOfAyahOrSurah(int number) {
    switch (number.toString().length) {
      case 1:
        return "00$number";
      case 2:
        return "0$number";

      case 3:
        return "$number";
      default:
        return "wrong number";
        break;
    }
  }

  String _getSingleAyahUrl(int surahNumber, String qari, int index) {
    String ayahNumber = getNumberOfAyahOrSurah(index);
    String surah = getNumberOfAyahOrSurah(surahNumber);
    return "$_audioEndPoint/$qari/$surah$ayahNumber.mp3";
  }

  @override
  List<String> getSurahUrls(
      int surahNumber, List<int> ayahIdOfSurah, String qari) {
    return List<String>.generate(ayahIdOfSurah.length + 1,
        (index) => _getSingleAyahUrl(surahNumber, qari, index));
  }
}

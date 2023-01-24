import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'downloadSurahStates.dart';
import '../../repository/listeningQuranRepository.dart';
import '../../service/remote/remoteDataSource.dart';
import '../../../../core/failure/failure.dart';
import 'package:riverpod/riverpod.dart';

import '../../service/downloadStatus/dowloadStatus.dart';

class DownloadSurahStateNotifier extends StateNotifier<DownloadSurahState> {
  final ListeningQuranRepository repositoryImp;
  DownloadSurahStateNotifier({@required this.repositoryImp})
      : super(initialState());

  Future<void> downloadSurahAudioFiles(
      int surahNumber, String qari, DownloadProgress downloadProgress) async {
    state = DownloadSurahLoadingState();

    final result =
        await repositoryImp.downloadSurah(surahNumber, qari, downloadProgress);

    result.fold((fail) {
      switch (fail.runtimeType) {
        case ServerFailure:
          state = ServerFailureState();
          break;
        case ConnectionFailure:
          state = ConnectionFailureState();
          break;
        case DatabaseFailure:
          state = DatabaseFailureState();
          break;
      }
    }, (success) {
      state = DownloadedState();
    });
  }
}

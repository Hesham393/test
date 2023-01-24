import 'package:dartz/dartz.dart';
import 'package:quran_twekl_app/Features/ListeningQuran/UI/pages/MediaPage/widgets/downloadStatus.dart';
import '../models/ayahAudio.dart';
import '../models/qariModel.dart';
import '../service/local/localDataSource.dart';
import '../service/remote/remoteDataSource.dart';
import '../../../core/error/error.dart';
import '../../../core/failure/failure.dart';
import '../../../core/platform/networkInfo.dart';

import '../service/downloadStatus/dowloadStatus.dart';

abstract class ListeningQuranRepository {
  Future<List<Qari>> getAllQari();
  Future<bool> isDownloadedSurah(int surahNumber, String qari);
  Future<List<AudioAyah>> getAudioAyahsOfSurah(int surahNumber, String qari);
  Future<Either<Failure, void>> downloadSurah(
      int surahNumber, String qari, DownloadProgress downloadProgress);
}

class ListeningQuranRepositoryImp extends ListeningQuranRepository {
  final LocalDataSource _localDataSourceImp;
  final RemoteDataSource _remoteDataSourceImp;
  final NetworkInfo _networkInfoImp;
  ListeningQuranRepositoryImp(
    this._localDataSourceImp,
    this._remoteDataSourceImp,
    this._networkInfoImp,
  );

  @override
  Future<Either<Failure, void>> downloadSurah(
      int surahNumber, String qari, DownloadProgress downloadProgress) async {
    if (await _networkInfoImp.hasConnection()) {
      try {
        // list of ayah id of surah
        final ayahIdOfSurah =
            await _localDataSourceImp.getAyahsIdOfSurah(surahNumber);
        downloadProgress.toggleDownloadProgress();
        //downloading list of audio files
        final audioFiles = await _remoteDataSourceImp.downloadAudioFilesOfSurah(
            surahNumber, ayahIdOfSurah, qari, downloadProgress);

        downloadProgress.toggleDownloadProgress();
        //saving on mobile device
        for (var audioFile in audioFiles) {
          final dir =
              await _localDataSourceImp.saveAudioFileOnDevice(audioFile);

          final audioAyah = AudioAyah(
              filePath: dir,
              qari: qari,
              ayah: audioFile.ayah,
              surah: surahNumber);
          //saving file path and some info on database
          await _localDataSourceImp.saveAudioFileOnDB(audioAyah);
        }
        downloadProgress.downloadAndFetchingCompeleted();

        // removing the caching download when the dowonload is completed.
        downloadStatus.downloads.removeWhere((download) =>
            download.qari == qari && download.surahNumber == surahNumber);
      } on ServerException {
        return Left(ServerFailure());
      } on ConnectionException {
        print("clinet exception connection exception --------------------");
        downloadProgress.errorhandling();
        downloadProgress.toggleDownloadProgress();
        downloadProgress.noError();
        downloadProgress.resetDownloadProgress();
        print(
            "error status: ${downloadProgress.errorStatus} -- download status : ${downloadProgress.getDownloadProgressStatus}");
        return Left(ConnectionFailure());
      } on Exception {
        return Left(DatabaseFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
    return const Right(null);
  }

  @override
  Future<List<Qari>> getAllQari() async => _localDataSourceImp.getAllQari();

  @override
  Future<List<AudioAyah>> getAudioAyahsOfSurah(
          int surahNumber, String qari) async =>
      await _localDataSourceImp.getAudioAyahsOfSurah(surahNumber, qari);

  @override
  Future<bool> isDownloadedSurah(int surahNumber, String qari) async =>
      await _localDataSourceImp.isDownloaded(surahNumber, qari);
}

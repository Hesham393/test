import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'customAudioProvider/customAudioProvider.dart';
import 'selectedQariChangeNotifier/selectedQariChangeNotifier.dart';

import '../models/qariModel.dart';
import '../repository/listeningQuranRepository.dart';
import '../service/local/localDataSource.dart';
import '../service/remote/remoteDataSource.dart';
import '../../../core/platform/networkInfo.dart';
import '../../../core/sqflite_database/db_helper.dart';

import '../UI/pages/AudioController/customPlaylist.dart';

// database provider
final _dbhelper = Provider<DBhelper>((ref) => DBhelper());

// dio http client provider

final _dioProvider = Provider<Dio>((ref) => Dio());
final _httpClinet = Provider<http.Client>(((ref) => http.Client()));

// data connection checker provider

final _dataConnectionCheckerProvider =
    Provider<DataConnectionChecker>((ref) => DataConnectionChecker());

// network info provider

final _networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImp(
    dataConnectionChecker: ref.read(_dataConnectionCheckerProvider)));

//local data source provider
final _localDataSourceProvider = Provider<LocalDataSource>(
    ((ref) => LocalDataSourceImp(dBhelper: ref.read(_dbhelper))));

//remote data source provder

final _remoteDataSource = Provider<RemoteDataSource>(
    ((ref) => RemoteDataSourceImp(httpClient: ref.read(_httpClinet))));

//listening quran repository provider

final listeningQuranRepositoryProvider = Provider<ListeningQuranRepository>(
    (ref) => ListeningQuranRepositoryImp(ref.read(_localDataSourceProvider),
        ref.read(_remoteDataSource), ref.read(_networkInfoProvider)));

// download surah state notifer provider

// final downloadSurahStateNotifierProvider =
//     StateNotifierProvider<DownloadSurahStateNotifier, DownloadSurahState>(

//         (ref) => DownloadSurahStateNotifier(
//             repositoryImp: ref.read(listeningQuranRepositoryProvider)));

// all qari provider

final getAllQariProvider = FutureProvider<List<Qari>>(
  (ref) => ref.read(listeningQuranRepositoryProvider).getAllQari(),
);

// selected qari provider

final selectedQariProvider = ChangeNotifierProvider<SelectedQariNotifier>(
  (ref) => SelectedQariNotifier(),
);

final customPlaylistProvider =
    ChangeNotifierProvider(((ref) => CustomPlayList()));

// custom audio player provider

final customAudioPlayerProvider =
    Provider((ref) => CustomAudioPlayerProvider());

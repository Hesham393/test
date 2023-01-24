import 'package:get_it/get_it.dart';
import 'Features/readQuran/UI/bloc/bloc.dart';
import 'Features/readQuran/dataSource/data/localDataSource.dart';
import 'Features/readQuran/dataSource/repository/readQuranRepositoryImp.dart';
import 'Features/readQuran/domain/repository/readQuranRepository.dart';
import 'Features/readQuran/domain/usecase/usecase.dart';
import 'core/sqflite_database/db_helper.dart';

final sl = GetIt.instance;
void init() {
  //! features ReadQuran

  //bloc

  sl.registerFactory(() => ReadQuranBloc(
      getAllSurah: sl(),
      getAllAyah: sl(),
      getAyahsOfPage: sl(),
      getListAyahsOfSurah: sl(),
      firstNumberPageOfSurah: sl(),
      getCountVersesOfPage: sl(),
      getCountVersesOfSurah: sl()));

  //Usecases

  sl.registerLazySingleton(() => GetAllSurah(sl()));
  sl.registerLazySingleton(() => GetAyahsOfPage(sl()));
  sl.registerLazySingleton(() => GetFirstNumberPageOfSurah(sl()));
  sl.registerLazySingleton(() => GetListAyahsOfSurah(sl()));
  sl.registerLazySingleton(() => GetCountVersesOfPage(sl()));
  sl.registerLazySingleton(() => GetCountVersesOfSurah(sl()));
  sl.registerLazySingleton(() => GetAllAyah(repository: sl()));

  //repository

  sl.registerLazySingleton<ReadQuranRepository>(
      () => ReadQuranRepositoryImp(sl()));

  // data source
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(dBhelper: sl()));

//! Core

//! External

  //database
  sl.registerLazySingleton(() => DBhelper());
}

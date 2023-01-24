import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'read_quran_scroll_controllerProvider.dart';
import '../Repository/juz_repository.dart';
import '../domain/entity/ayah.dart';
import '../domain/entity/surah.dart';
import 'get_first_page_surah.dart';
import '../../../core/sqflite_database/db_helper.dart';
import '../Repository/read_quran_repository.dart';
import '../UI/widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';
import 'language_provider.dart';

// database provider
final _dbhelper = Provider<DBhelper>(
  (ref) => DBhelper(),
);

// read quran repository provider
final readQuranRepository = Provider<ReadQuranRepository>(
    (ref) => ReadQuranRepositoryImp(dBhelper: ref.watch(_dbhelper)));

// future all surah provider
final allSurahProvider = FutureProvider<List<Surah>>((ref) async {
  return await ref.read(readQuranRepository).getAllSurah();
});

// future all ayah provider
final allAyahProvider = FutureProvider<List<Ayah>>(
  (ref) async => await ref.read(readQuranRepository).getAllAyah(),
);

// first page of surah provider

final firstPageOfSurahProvider =
    Provider.autoDispose<MapPageToSurah>((ref) => MapPageToSurah());
//selected surah indexing provider when u click on surah that remain as selected

final SelectedSurahIndexProvider = StateProvider<int>((ref) => 0);

// juz data provider
final juzInformationProvider =
    Provider.autoDispose<JuzRepository>((ref) => JuzRepository());

// selected juz indexing provider when u click on juz that remain as selected
final juzSelectedIndexProvider = StateProvider<int>(
  (ref) => 0,
);

// map page to juz provider

final getJuzByPageProvider = Provider.autoDispose.family<int, int>(
  (ref, pageNumber) =>
      ref.read(juzInformationProvider).getJuzByPage(pageNumber),
);

// quran accessing seleted state surah or juz or bookmark or page ...etc
final accessQuranSelectedState =
    StateProvider<String>(((ref) => SelectHomeStates.Surah.name));

//quran font size provider

final quranFontSize = StateProvider<double>(
  (ref) => 20.0,
);

// language provider
final languageProvider = ChangeNotifierProvider((ref) => LanguageProvider());

//quran page index provider
final quranPageIndexProvider = StateProvider.autoDispose<int>((ref) => 1);

//read quran scroll controller provider

final readQuranScrollControllerProvider =
    Provider<ReadQuranScrollController>(((ref) => ReadQuranScrollController()));

final readQuranControllerFlag = StateProvider(((ref) => false));

final bottomNavigationIndexProvider = StateProvider(
  (ref) => 0,
);

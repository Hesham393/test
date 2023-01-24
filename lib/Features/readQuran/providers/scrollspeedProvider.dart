import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/selectScrollSpeedDropButton.dart';
import 'package:riverpod/riverpod.dart';

final scrollSpeedProvider =
    StateProvider<String>((ref) => ScrollSpeeds.normal);

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/adhan_dart_service.dart';

final allPrayerTimesProvider =
    FutureProvider((ref) async => await AdhanDartService.getPrayerTimes());

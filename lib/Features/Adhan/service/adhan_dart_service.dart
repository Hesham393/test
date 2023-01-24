import 'package:adhan_dart/adhan_dart.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:geolocator/geolocator.dart';

class AdhanDartService {
  static Future<List<String>> getPrayerTimes() async {
    tz.initializeTimeZones();
    tz.Location timezone = tz.local;
    print(timezone.name);

    DateTime date = tz.TZDateTime.from(DateTime.now(), timezone);
    final params = CalculationMethod.Karachi();
    params.madhab = Madhab.Hanafi;
    await checkPermission();
    final coordinates = await getCurrentLocation();

    final erbilCoordinates = Coordinates(
      36.1901,
      43.9930,
    );
    final PrayerTimes prayerTimes =
        PrayerTimes(erbilCoordinates, date, params, precision: true);

    DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr, timezone);
    DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise, timezone);
    DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr, timezone);
    DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr, timezone);
    DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib, timezone);
    DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha, timezone);

    List<String> prayerTimesList = [];

    prayerTimesList.add(DateFormat.jm().format(fajrTime));
    prayerTimesList.add(DateFormat.jm().format(sunriseTime));
    prayerTimesList.add(DateFormat.jm().format(dhuhrTime));
    prayerTimesList.add(DateFormat.jm().format(asrTime));
    prayerTimesList.add(DateFormat.jm().format(maghribTime));
    prayerTimesList.add(DateFormat.jm().format(ishaTime));

    return prayerTimesList;
    // DateTime ishabeforeTime =
    //     tz.TZDateTime.from(prayerTimes.ishabefore, timezone);
    // DateTime fajrafterTime =
    //     tz.TZDateTime.from(prayerTimes.fajrafter, timezone);
  }

  static Future<Coordinates> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Coordinates(position.latitude, position.longitude);
  }

  static Future<void> checkPermission() async {
    final permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus != LocationPermission.always ||
        permissionStatus != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }
  }
}

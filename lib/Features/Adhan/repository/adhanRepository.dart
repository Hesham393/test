import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import '../models/adhan.dart';
import 'package:geolocator/geolocator.dart';

class AdhanRepository {
  Coordinates getCoordinatesOfLocation(double lat, double long) {
    return Coordinates(lat, long);
  }

  static Future<Coordinates> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Coordinates(position.latitude, position.longitude);
  }

  Future<List<String>> getAllPrayerTime() async {
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;
    final currentCoordinates = await getCurrentLocation();
    print(currentCoordinates.latitude);
    print(currentCoordinates.longitude);
    final prayerTimes = PrayerTimes.today(currentCoordinates, params);
    List<String> prayerTimesList = [];

    prayerTimesList.add(DateFormat.jm().format(prayerTimes.fajr));
    prayerTimesList.add(DateFormat.jm().format(prayerTimes.sunrise));
    prayerTimesList.add(DateFormat.jm().format(prayerTimes.dhuhr));
    prayerTimesList.add(DateFormat.jm().format(prayerTimes.asr));
    prayerTimesList.add(DateFormat.jm().format(prayerTimes.maghrib));
    prayerTimesList.add(DateFormat.jm().format(prayerTimes.isha));
    return prayerTimesList;
  }
}

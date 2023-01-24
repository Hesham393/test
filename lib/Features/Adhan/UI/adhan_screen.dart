import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'adhan_second.screen.dart';
import '../providers/providers.dart';
import '../service/adhan_dart_service.dart';
import '../../readQuran/UI/page/home_page.dart';
import '../../readQuran/UI/widget/custom_bottom_navigation_home.dart';
import '../../../core/constant/constants.dart';
import '../../../core/responsiveness/responsive.dart';
import '../../../core/sizeConfig/theme_configuration.dart';
import '../../../materialColor/pallete.dart';
import '../../../services/NotificationService/notificationservice.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/fonts/font.dart';

enum PrayerNames { Fajr, Sunrise, Dhuhur, Asr, Maghrib, Isha }

class AdhanScreen extends ConsumerStatefulWidget {
  static const String routeName = "/Adhan-screen";

  @override
  ConsumerState<AdhanScreen> createState() => _AdhanScreenState();
}

class _AdhanScreenState extends ConsumerState<AdhanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 100,
    // );

    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   AndroidSettings(
    //       accuracy: LocationAccuracy.high,
    //       distanceFilter: 100,
    //       forceLocationManager: true,
    //       intervalDuration: const Duration(seconds: 10),
    //       //(Optional) Set foreground notification config to keep the app alive
    //       //when going to the background
    //       foregroundNotificationConfig: const ForegroundNotificationConfig(
    //         notificationText:
    //             "Example app will continue to receive your location even when you aren't using it",
    //         notificationTitle: "Running in Background",
    //         enableWakeLock: true,
    //       ));
    // } else if (defaultTargetPlatform == TargetPlatform.iOS ||
    //     defaultTargetPlatform == TargetPlatform.macOS) {
    //   locationSettings = AppleSettings(
    //     accuracy: LocationAccuracy.high,
    //     activityType: ActivityType.fitness,
    //     distanceFilter: 100,
    //     pauseLocationUpdatesAutomatically: true,
    //     // Only set to true if our app will be started up in the background.
    //     showBackgroundLocationIndicator: false,
    //   );
    // } else {
    //   locationSettings = LocationSettings(
    //     accuracy: LocationAccuracy.high,
    //     distanceFilter: 100,
    //   );
    // }

    // _location.enableBackgroundMode(enable: true);
    NotificationService.initialize1(onDidReceiveNotificationResponse);

    // listenToNotification();
    // BackgroundLocationService.init();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await AdhanDartService.checkPermission();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Prayer Times"),
        shape: appBarShape,
        flexibleSpace: const LinearColor(),
      ),
      // bottomNavigationBar: const customBottomNavigationBarHome(currentPage: 3),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final _data = ref.watch(allPrayerTimesProvider);
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefalultHorizontalPadding,
            vertical: kDefalultVerticalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              nextPrayer(),
              _data.when(
                  data: (data) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                getPercentageOfResponsiveHeight(12, context)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List<Widget>.generate(6, (index) {
                              return PrayerTimeWidget(data[index],
                                  PrayerNames.values[index].name, context);
                            })),
                      ),
                  error: ((error, stackTrace) => Text("${error.toString()}")),
                  loading: (() => const CircularProgressIndicator())),
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationService.displayNotification(
              //           "Adhan", "The Maghrib Adhan Time");
              //     },
              //     child: const Text("show Notification")),
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationService.displayZonedNotification(
              //           "Adhan", "The Maghrib Adhan Time", 5);
              //     },
              //     child: const Text("show Zoned Notification")),
              // ElevatedButton(
              //     onPressed: () async {
              //       await NotificationService.displayNotificationWithPayload(
              //           "Adhan", "The Maghrib Adhan Time", "payload");
              //     },
              //     child: const Text("show Notification With Payload")),
            ],
          ),
        )

        // Consumer(
        //   builder: (context, ref, child) => Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: List<Widget>.generate(6, (index) {
        //         final prayerTimes =
        //             ref.watch(allPrayerTimesProvider).getAllPrayerTime();

        //         return PrayerTimeWidget(
        //             prayerTimes[index], PrayerNames.values[index].name, context);
        //       })),
        // ),
        );
  }

  Widget PrayerTimeWidget(String time, String name, BuildContext context) {
    ThemeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            color: pallete.ayahColor,
            border: Border.all(width: 1, color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: getPercentageOfResponsiveWidth(70, context),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: ThemeConfig.generalHeadline,
                  )),
              // SizedBox(
              //   width: getPercentageOfResponsiveWidth(30, context),
              // ),
              SizedBox(
                width: getPercentageOfResponsiveWidth(90, context),
                child: Text(
                  time,
                  textAlign: TextAlign.center,
                  style: ThemeConfig.generalHeadline,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void listenToNotification() => NotificationService.onNotificationClick.stream
  //     .listen(onNotificationListener);

  // void onNotificationListener(String payload) {
  //   print("listen data");
  //   if (payload.isNotEmpty && payload != null) {
  //     print('payload: $payload');
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: ((context) => AdhanSecond(payload: payload))));
  //   }
  // }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => AdhanSecond(payload: payload))));
    }
    print("onDidReceiveNotificationResponse");
  }
}

class nextPrayer extends StatelessWidget {
  const nextPrayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeConfig().init(context);
    return Card(
      // decoration: BoxDecoration(
      //     color: pallete.secondaryColor,
      //     borderRadius: BorderRadius.circular(15)),
      color: pallete.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text("Next Prayer Time",
                    style: ThemeConfig.headline1
                        .copyWith(color: Colors.white, fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "02:46:59",
                  style: ThemeConfig.headline1.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/images/mosque.png"))
        ],
      ),
    );
  }
}

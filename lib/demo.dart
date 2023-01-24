import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/customPageView.dart';
import 'Features/readQuran/domain/entity/ayah.dart';

import 'core/sqflite_database/db_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.title);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBhelper mydb;
  List<Ayah> ayahs;

  PageController pageController = PageController();

  static const String playListPath =
      "/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy";
  // Define the playlist

  @override
  void initState() {
    mydb = DBhelper();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: customBottomController(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        // body: ScrollSnapList(
        //   itemBuilder: (_, index) {

        //   },
        //   itemCount: 49,
        //   onItemFocus: (index){},
        //   itemSize: ,
        // ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: mydb.getAyahsOfPage(index),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustompageView(
                    ayahs: snapshot.data,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
          itemCount: 50,
        ));
  }
}

const double iconSize = 30;

class customBottomController extends StatefulWidget {
  const customBottomController({
    Key key,
  }) : super(key: key);

  @override
  State<customBottomController> createState() => _customBottomControllerState();
}

class _customBottomControllerState extends State<customBottomController> {
  static AudioPlayer player;

  static bool isPlay = false;
  static int surahNumber = 1;
  static Duration duration = Duration.zero;
  static Duration currentPosition = Duration.zero;
  final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),

      // Specify the playlist items
      children:
          // List<AudioSource.uri(Uri.parse("uri"))>.generate(7, (index) {
          //   return AudioSource.uri(Uri.parse(playListPath+"/audio$index.mpga"));
          //   }
          //   );
          List<UriAudioSource>.generate(
        7,
        (index) => AudioSource.uri(Uri.parse(
            '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio$index.mpga')),
      )
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio1.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio2.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio3.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio4.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio5.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio6.mpga')),
      // AudioSource.uri(Uri.parse(
      //     '/data/user/0/com.example.quran_twekl_app/files/QuranAudios/Surah1/ar.alafasy/audio7.mpga')),
      // ],
      );

  static StreamController<int> controller = StreamController<int>();
  static Stream customStream = controller.stream;

  static int selectedIndex = 1;

  @override
  void initState() {
    player = AudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialize_player();
    });

    player.currentIndexStream.listen((index) {
      controller.add(index);
      setState(() {
        selectedIndex = index;
      });
    });

    player.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    player.durationStream.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.playerStateStream.listen((event) {
      if (event.playing) {
        setState(() {
          isPlay = true;
        });
      } else {
        setState(() {
          isPlay = false;
        });
      }
    });
    super.initState();
  }

  Future<void> initialize_player() async {
    await player.setAudioSource(playlist,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  Future<void> _play() async {
    await player.play();
  }

  Future<void> _pause() async {
    await player.pause();
  }

  Future<void> _next() async {
    await player.seekToNext();
  }

  Future<void> _previous() async {
    await player.seekToPrevious();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
                blurRadius: 20,
                color: Color(0xFFDADADA),
                offset: Offset(0, -15))
          ],
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25),
              topRight: const Radius.circular(25))),
      height: 130,
      child: Column(
        children: [
          // Slider(
          //   min: 0.0,
          //   max: isPlay ? duration.inMilliseconds.toDouble() : 1,
          //   onChanged: (value) async {
          //     await player!.seek(Duration(milliseconds: value.toInt()));
          //   },
          //   value: isPlay ? currentPosition.inMilliseconds.toDouble() : 0.0,
          // ),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              iconSize: iconSize,
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.skip_previous),
              onPressed: () async {
                await _previous();
              },
            ),
            IconButton(
              iconSize: iconSize,
              color: Theme.of(context).primaryColor,
              icon: isPlay ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: () async {
                if (isPlay) {
                  await _pause();
                } else {
                  await _play();
                }
              },
            ),
            IconButton(
              iconSize: iconSize,
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.skip_next),
              onPressed: () async {
                await _next();
              },
            )
          ]),
          ElevatedButton(
            onPressed: () async {
              print("start");
              DBhelper db = DBhelper();
              // final list = await db.getAyahsIdOfSurah(1);
              // print(list);
              // await httpService.httpGetListOfAudio([1,2,3,4,5,6,7]);
              //   await httpService.httpGetDownloadSurah(2,db);
              //await httpService.httpgetAyahsOfSurah(2,db);
              print("finish");
              //  await httpService.httpgetAyahsOfSurah(2,db);
              //  final listId=await db.getAyahsIdOfSurah(1);
            },
            child: Text("Download Surah Al-Faitha"),
          ),
        ],
      ),
    );
  }
}

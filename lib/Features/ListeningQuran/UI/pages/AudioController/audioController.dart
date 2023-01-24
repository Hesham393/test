import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/home_page.dart';
import 'package:quran_twekl_app/core/platform/networkInfo.dart';
import 'package:quran_twekl_app/core/responsiveness/responsive.dart';
import '../../../../readQuran/UI/page/ReadQuranPage/read_quran_widget/scrollFormDialogWT.dart';
import '../../../Providers/providers.dart';
import 'customPlaylist.dart';
import '../../../../readQuran/providers/providers.dart';
import '../../../../../core/sizeConfig/theme_configuration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../materialColor/pallete.dart';

const AudioControllerImages = {
  // "nextAyah-right":
  //     "assets/images/AudioController/next-ayah-right-controller-icon.png",
  "nextAyah-right": "assets/images/AudioController/next.png",
  //   "nextAyah-left":
  // "assets/images/AudioController/next-ayah-left-controller-icon.png",
  "nextAyah-left": "assets/images/AudioController/back.png",
  //   "nextSurah-right":
  // "assets/images/AudioController/next-surah-right-controller-icon.png",
  "nextSurah-right": "assets/images/AudioController/next_audio.png",
  // "nextSurah-left":
  // "assets/images/AudioController/next-surah-left-controller-icon.png"
  "nextSurah-left": "assets/images/AudioController/back_audio.png",
};

class AudioController extends ConsumerStatefulWidget {
  final Animation<double> opacityAnimation;
  final Animation<Offset> slideAnimation;

  AudioController({
    @required this.opacityAnimation,
    @required this.slideAnimation,
  });
  @override
  ConsumerState<AudioController> createState() => _AudioControllerState();
}

class _AudioControllerState extends ConsumerState<AudioController> {
  int _ayahIndex;
  AudioPlayer _audioPlayer;
  CustomPlayList _customPlayList;
  bool _isPlay;
  bool _isOnlyAyah;
  PlayerState _playerState;
  @override
  void initState() {
    initMethod();
    streams();
    super.initState();
  }

  void streams() {
    _audioPlayer.onPlayerComplete.listen(onPlayerCompleted);
    _audioPlayer.onPlayerStateChanged.listen(onPlayerStateChanged);
  }

  Future<void> onPlayerCompleted(void event) async {
    print(_playerState.toString());
    await setAudio();
  }

  void onPlayerStateChanged(PlayerState state) {
    if (!mounted) {
      return;
    }

    if (state == PlayerState.playing) {
      setState(() {
        _playerState = state;
        _isPlay = true;
        _customPlayList.setPlay();
      });
    } else if (state == PlayerState.stopped) {
      setState(() {
        _playerState = state;
        _isPlay = false;
        _customPlayList.setPause();
      });
    }
  }

  void initMethod() {
    _ayahIndex = 0;
    _audioPlayer = AudioPlayer();
    _isPlay = false;
    _isOnlyAyah = false;
    _customPlayList = ref.read(customPlaylistProvider);
    ref
        .read(customAudioPlayerProvider)
        .setPlayFunction(playCurrentOrStartingFromCurrent);
  }

  Future<void> setAudio() async {
    _ayahIndex++;
    _customPlayList.setAyahIndex(_ayahIndex);
    print(_isPlay);
    if (_ayahIndex < _customPlayList.length && !_isOnlyAyah) {
      await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);
      _customPlayList.setPlay();
    } else {
      await _audioPlayer.pause();
      _customPlayList.setPause();
      _isOnlyAyah = false;
    }
  }

  Future<void> setPlaylist(int surahNumber, String qari) async {
    if (surahNumber != _customPlayList.surahNumber ||
        _customPlayList.length == 0 ||
        qari != _customPlayList.getQari) {
      _customPlayList.setQari(qari);

      final audioFiles = await ref
          .read(listeningQuranRepositoryProvider)
          .getAudioAyahsOfSurah(surahNumber, qari);

      final audioSources = List<Source>.generate(audioFiles.length,
          (index) => DeviceFileSource(audioFiles[index].filePath));
      if (_customPlayList.length > 0) {
        _customPlayList.clearAll();
      }
      _customPlayList.addAllSource(audioSources);
      _customPlayList.setSurahNumber(surahNumber);
      _customPlayList.setAyahIndex(_ayahIndex);
      if (_ayahIndex > _customPlayList.length) {
        resetAyahIndex();
      }
    }
  }

  Future<void> playSurah(int surahNumber, String qari) async {
    await setPlaylist(surahNumber, qari);
    if (_customPlayList.length == 0) {
      showSnackBar("Sorry,Surah has been not available.", context);
      return;
    }
    await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);

    _customPlayList.setPlay();
  }

  Future<void> pause() async {
    if (_isPlay) {
      await _audioPlayer.pause();
      _customPlayList.setPause();
    }
  }

  Future<void> nextAyah() async {
    if (_ayahIndex < _customPlayList.length - 1 && _isPlay) {
      _ayahIndex++;
      _customPlayList.setAyahIndex(_ayahIndex);
      await playSurah(_customPlayList.surahNumber, _customPlayList.getQari);
    }
  }

  Future<void> previousAyah() async {
    if (_ayahIndex > 0 && _isPlay) {
      _ayahIndex--;
      _customPlayList.setAyahIndex(_ayahIndex);
      await playSurah(_customPlayList.surahNumber, _customPlayList.getQari);
    }
  }

  void resetAyahIndex() {
    _ayahIndex = 0;
    _customPlayList.setAyahIndex(_ayahIndex);
  }

  Future<void> nextSurah() async => await nextOrPreviousSurah(isNext: true);

  Future<void> nextOrPreviousSurah({bool isNext = false}) async {
    final newSurah = isNext
        ? _customPlayList.surahNumber + 1
        : _customPlayList.surahNumber - 1;
    final qari = _customPlayList.getQari;
    if (newSurah < 1 || newSurah > 114) {
      return;
    }

    final isDonwloaded = await ref
        .read(listeningQuranRepositoryProvider)
        .isDownloadedSurah(newSurah, qari);
    if (!isDonwloaded && _isPlay) {
      return;
    }
    resetAyahIndex();
    await playSurah(newSurah, qari);
  }

  Future<void> playCurrentOrStartingFromCurrent(
      {int surahNumber,
      int ayahIndex,
      String qari,
      bool isOnlyAyah = false}) async {
    _ayahIndex = ayahIndex;
    _customPlayList.setAyahIndex(_ayahIndex);
    await playSurah(surahNumber, qari);
    // await setPlaylist(surahNumber, qari);

    // _ayahIndex = ayahIndex;
    // _customPlayList.setAyahIndex(_ayahIndex);
    // await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);
    // _customPlayList.setPlay();
    if (isOnlyAyah) {
      _isOnlyAyah = true;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lan = ref.watch(languageProvider).getLocale.languageCode;
    final leftSide = lan == "en" ? "left" : "right";
    final rightSide = lan == "en" ? "right" : "left";
    return SlideTransition(
      position: widget.slideAnimation,
      child: FadeTransition(
        opacity: widget.opacityAnimation,
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //next surah
                AudioControllerButton(nextOrPreviousSurah,
                    AudioControllerImages["nextSurah-$leftSide"]),
                AudioControllerButton(
                    previousAyah, AudioControllerImages["nextAyah-$leftSide"]),
                IconButton(
                  onPressed: () async {
                    if (!_isPlay) {
                      await playSurah(
                          _customPlayList.surahNumber, _customPlayList.getQari);
                    } else {
                      await pause();
                    }
                  },
                  icon: _isPlay
                      ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                ),
                AudioControllerButton(
                    nextAyah, AudioControllerImages["nextAyah-$rightSide"]),
                AudioControllerButton(
                    nextSurah, AudioControllerImages["nextSurah-$rightSide"]),
              ]),
        ),
      ),
    );
  }
}

class AudioController2 extends ConsumerStatefulWidget {
  @override
  ConsumerState<AudioController2> createState() => _AudioControllerState2();
}

class _AudioControllerState2 extends ConsumerState<AudioController2> {
  int _ayahIndex;
  AudioPlayer _audioPlayer;
  CustomPlayList _customPlayList;
  bool _isPlay;
  bool _isOnlyAyah;
  PlayerState _playerState;
  @override
  void initState() {
    initMethod();
    streams();
    super.initState();
  }

  void streams() {
    _audioPlayer.onPlayerComplete.listen(onPlayerCompleted);
    _audioPlayer.onPlayerStateChanged.listen(onPlayerStateChanged);
  }

  Future<void> onPlayerCompleted(void event) async {
    await setAudio();
  }

  void onPlayerStateChanged(PlayerState state) {
    if (!mounted) {
      return;
    }

    if (state == PlayerState.playing) {
      setState(() {
        _playerState = state;
        _isPlay = true;
        _customPlayList.setPlay();
      });
    }
    // else if (state == PlayerState.completed && _ayahIndex == 0) {
    //   _ayahIndex--;
    // }
    else if (state == PlayerState.stopped || state == PlayerState.paused) {
      setState(() {
        _playerState = state;
        _isPlay = false;
        _customPlayList.setPause();
      });
    }
  }

  void initMethod() {
    _ayahIndex = 0;
    _audioPlayer = AudioPlayer();
    _isPlay = false;
    _isOnlyAyah = false;
    _customPlayList = ref.read(customPlaylistProvider);
    ref
        .read(customAudioPlayerProvider)
        .setPlayFunction(playCurrentOrStartingFromCurrent);
  }

  Future<void> setAudio() async {
    _ayahIndex++;
    _customPlayList.setAyahIndex(_ayahIndex);
    if (_ayahIndex < _customPlayList.length && !_isOnlyAyah) {
      _audioPlayer.setSource(_customPlayList.sources[_ayahIndex]);
      await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);
      _customPlayList.setPlay();
    } else {
      await _audioPlayer.pause();
      _customPlayList.setPause();
      _isOnlyAyah = false;
    }
  }

  Future<void> setPlaylist(int surahNumber, String qari) async {
    if (surahNumber != _customPlayList.surahNumber ||
        _customPlayList.length == 0 ||
        qari != _customPlayList.getQari ||
        _customPlayList.isUrlSource()) {
      _customPlayList.setQari(qari);

      final audioFiles = await ref
          .read(listeningQuranRepositoryProvider)
          .getAudioAyahsOfSurah(surahNumber, qari);

      List<Source> audioSources = List<Source>.generate(audioFiles.length,
          (index) => DeviceFileSource(audioFiles[index].filePath));

      if (audioSources.isEmpty) {
        print("stream audio");
        final surahURLs = await ref
            .read(listeningQuranRepositoryProvider)
            .getSurahUrls(surahNumber, qari);

        audioSources = List<Source>.generate(
            surahURLs.length, (index) => UrlSource(surahURLs[index]));
      }
      if (_customPlayList.length > 0) {
        _customPlayList.clearAll();
      }
      _customPlayList.addAllSource(audioSources);
      _customPlayList.setSurahNumber(surahNumber);
      _customPlayList.setAyahIndex(_ayahIndex);
      if (_ayahIndex > _customPlayList.length) {
        resetAyahIndex();
      }
    }
  }

  Future<void> playSurah(int surahNumber, String qari) async {
    await setPlaylist(surahNumber, qari);
    // if (_customPlayList.length == 0) {
    //   // final surahURLs = await ref
    //   //     .read(listeningQuranRepositoryProvider)
    //   //     .getSurahUrls(surahNumber, qari);
    //   // // _audioPlayer.setSourceUrl(surahURLs[0]);
    //   // surahURLs.forEach((element) {
    //   //   print(element);
    //   // });
    //   // await _audioPlayer.play(UrlSource(surahURLs[1]));
    //   // showSnackBar("Sorry,Surah has been not available.", context);
    //   return;
    // }
    await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);
    _customPlayList.setPlay();
  }

  Future<void> pause() async {
    if (_isPlay) {
      await _audioPlayer.pause();

      _customPlayList.setPause();
    }
  }

  Future<void> nextAyah() async {
    if (_ayahIndex < _customPlayList.length - 1 && _isPlay) {
      _ayahIndex++;
      _customPlayList.setAyahIndex(_ayahIndex);
      await playSurah(_customPlayList.surahNumber, _customPlayList.getQari);
    }
  }

  Future<void> previousAyah() async {
    if (_ayahIndex > 0 && _isPlay) {
      _ayahIndex--;
      _customPlayList.setAyahIndex(_ayahIndex);
      await playSurah(_customPlayList.surahNumber, _customPlayList.getQari);
    }
  }

  void resetAyahIndex() {
    _ayahIndex = 0;
    _customPlayList.setAyahIndex(_ayahIndex);
  }

  Future<void> nextSurah() async => await nextOrPreviousSurah(isNext: true);

  Future<void> nextOrPreviousSurah({bool isNext = false}) async {
    final newSurah = isNext
        ? _customPlayList.surahNumber + 1
        : _customPlayList.surahNumber - 1;
    final qari = _customPlayList.getQari;
    if (newSurah < 1 || newSurah > 114) {
      return;
    }

    final isDonwloaded = await ref
        .read(listeningQuranRepositoryProvider)
        .isDownloadedSurah(newSurah, qari);
    if (!isDonwloaded && _isPlay) {
      return;
    }
    resetAyahIndex();
    await playSurah(newSurah, qari);
  }

  Future<void> playCurrentOrStartingFromCurrent(
      {int surahNumber,
      int ayahIndex,
      String qari,
      bool isOnlyAyah = false}) async {
    _ayahIndex = ayahIndex;
    _customPlayList.setAyahIndex(_ayahIndex);
    await playSurah(surahNumber, qari);
    // await setPlaylist(surahNumber, qari);

    // _ayahIndex = ayahIndex;
    // _customPlayList.setAyahIndex(_ayahIndex);
    // await _audioPlayer.play(_customPlayList.sources[_ayahIndex]);
    // _customPlayList.setPlay();
    if (isOnlyAyah) {
      _isOnlyAyah = true;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lan = ref.watch(languageProvider).getLocale.languageCode;
    final leftSide = lan == "en" ? "left" : "right";
    final rightSide = lan == "en" ? "right" : "left";
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: getPercentageOfResponsiveWidth(5, context)),
          //   child: AudioControllerButton(() {
          //     Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          //     ref.read(bottomNavigationIndexProvider.notifier).state = 0;
          //   }, "assets/images/home.png", size: 25),
          // ),
          //next surah
          // Expanded(
          //   child: Row(

          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          AudioControllerButton(nextOrPreviousSurah,
              AudioControllerImages["nextSurah-$leftSide"]),
          AudioControllerButton(
              previousAyah, AudioControllerImages["nextAyah-$leftSide"]),
          IconButton(
            onPressed: () async {
              if (!_isPlay) {
                await playSurah(
                    _customPlayList.surahNumber, _customPlayList.getQari);
              } else {
                await pause();
              }
            },
            icon: _isPlay
                ? createAudioControllerIcon(
                    "assets/images/AudioController/pause.png")
                : createAudioControllerIcon(
                    "assets/images/AudioController/play_btn.png"),
          ),
          AudioControllerButton(
              nextAyah, AudioControllerImages["nextAyah-$rightSide"]),
          AudioControllerButton(
              nextSurah, AudioControllerImages["nextSurah-$rightSide"]),
          // ],
          // ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       right: getPercentageOfResponsiveWidth(5, context)),
          //   child: AudioControllerButton(() {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         // ThemeConfig().init(context);
          //         // final textStyle = ThemeConfig.generalHeadline;
          //         return ScrollFormDialog(
          //             animatedToIndex: ref
          //                 .read(readQuranScrollControllerProvider)
          //                 .animatedToIndex);
          //       },
          //     );
          //   }, "assets/images/scroll.png", size: 25),
          // ),
          // AudioControllerButton(() {
          //   Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          //   ref.read(bottomNavigationIndexProvider.notifier).state = 0;
          // }, "assets/images/home.png"),
        ]);
  }
}

void showSnackBar(String text, BuildContext context) {
  ThemeConfig().init(context);
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: pallete.secondaryColor,
      duration: const Duration(milliseconds: 750),
      content: Text(
        AppLocalizations.of(context).surah_not_exist,
        style: ThemeConfig.juzStartFont.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      )));
}

Widget AudioControllerButton(Function action, String path, {double size = 20}) {
  return IconButton(
    onPressed: () async => await action(),
    icon: createAudioControllerIcon(path, size: size),
  );
}

Widget createAudioControllerIcon(String path, {double size = 20}) {
  return SizedBox(
    width: size,
    height: size,
    child: Image.asset(
      path,
      fit: BoxFit.contain,
    ),
  );
}

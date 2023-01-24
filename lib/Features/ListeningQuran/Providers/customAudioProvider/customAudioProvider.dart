class CustomAudioPlayerProvider {
  Function playCurrentAyahOrStartingFromCurrent;

  void setPlayFunction(Function action) {
    final currentAyah = action;
    playCurrentAyahOrStartingFromCurrent = currentAyah;
  }

  bool get isFunctionSet =>
      playCurrentAyahOrStartingFromCurrent != null ;
}

// class CustomAudioPlayer {
//   AudioPlayer _audioPlayer;
//   bool _isPlay = false;
//   bool _isAudioPlayerSet = false;
//   WidgetRef _ref;

//   void setPlay() {
//     _isPlay = true;
//     _ref.read(customPlaylistProvider).setPlay();
//   }

//   void setPause() {
//     _isPlay = false;
//     _ref.read(customPlaylistProvider).setPlay();
//   }

//   void setRef(WidgetRef ref) {
//     _ref = ref;
//   }

//   void setAudioPlayer(AudioPlayer audioPlayer) {
//     _audioPlayer = audioPlayer;
//   }

//   void setAyahIndex(int index) {
//     _ref.read(customPlaylistProvider).setAyahIndex(index);
//   }

//   Future<void> setAudio() async {
//     if (!isAudioPlayerSet) return;
//     _ref.read(customPlaylistProvider).increaseAyahIndexByOne();
//     if (_ref.read(customPlaylistProvider).ayahIndex <
//         _ref.read(customPlaylistProvider).length) {
//       await _audioPlayer.play(_ref
//           .read(customPlaylistProvider)
//           .sources[_ref.read(customPlaylistProvider).ayahIndex]);
//       setPlay();
//     } else {
//       await _audioPlayer.pause();
//       setPause();
//     }
//   }

//   Future<void> _setPlayList({
//     int surahNumber,
//     String qari,
//   }) async {
//     if (surahNumber != _ref.read(customPlaylistProvider).surahNumber ||
//         _ref.read(customPlaylistProvider).length == 0) {
//       final audioAyahs = await _ref
//           .read(listeningQuranRepositoryProvider)
//           .getAudioAyahsOfSurah(surahNumber, qari);
//       final audioSource = List<Source>.generate(audioAyahs.length, (index) {
//         return DeviceFileSource((audioAyahs[index].filePath));
//       });
//       if (_ref.read(customPlaylistProvider).length > 0) {
//         _ref.read(customPlaylistProvider).clearAll();
//       }
//       _ref.read(customPlaylistProvider).addAllSource(
//             audioSource,
//           );
//       _ref.read(customPlaylistProvider).setSurahNumber(surahNumber);
//       setAyahIndex(_ref.read(customPlaylistProvider).ayahIndex);
//     }
//     if (_ref.read(customPlaylistProvider).ayahIndex >=
//         _ref.read(customPlaylistProvider).length) {
//       _ref.read(customPlaylistProvider).setAyahIndex(0);
//     }
//   }

//   Future<void> pause() async {
//     if (isPlay) {
//       await _audioPlayer.pause();
//       setPause();
//     }
//   }

//   Future<void> nextSurah() async => await nextSurahOrPreviouse(isNext: true);
//   Future<void> previousSurah() async => await nextSurahOrPreviouse();
//   Future<void> nextSurahOrPreviouse({bool isNext = false}) async {
//     if (isPlay) {
//       if (_ref.read(customPlaylistProvider).surahNumber > 1 &&
//           _ref.read(customPlaylistProvider).surahNumber < 114) {
//         final newSurah = isNext
//             ? _ref.read(customPlaylistProvider).surahNumber + 1
//             : _ref.read(customPlaylistProvider).surahNumber - 1;
//         final qari = _ref.read(selectedQariProvider).getQari.id;

//         final isDonwloaded = await _ref
//             .read(listeningQuranRepositoryProvider)
//             .isDownloadedSurah(newSurah, qari);
//         if (isDonwloaded) {
//           await pause();
//           await _setPlayList(surahNumber: newSurah, qari: qari);
//           await playSurah(newSurah, qari);
//         } else {
//           final nextOrPre = isNext ? "next" : "previous";
//           print("soryy, $nextOrPre surah has not been available");
//           // showSnackBar("soryy, $nextOrPre surah has not been available");
//         }
//       }
//     }
//   }

//   Future<void> playOnlyCurrentAyah(
//       int surah, int ayahIndex, String qari) async {
//     await _setPlayList(surahNumber: surah, qari: qari);
//     await _audioPlayer
//         .play(_ref.read(customPlaylistProvider).sources[ayahIndex]);
//     setPlay();
//     await _audioPlayer.pause();
//     setPause();
//   }

//   Future<void> playSurahStartingFromSelectedAyah(
//       {int surah, int ayahIndex, String qari}) async {
//     await _setPlayList(surahNumber: surah, qari: qari);
//     await _audioPlayer
//         .play(_ref.read(customPlaylistProvider).sources[ayahIndex]);
//   }

//   Future<void> playSurah(
//     int surahNumber,
//     String qari,
//   ) async {
//     if (!isPlay && isAudioPlayerSet) {
//       await _setPlayList(surahNumber: surahNumber, qari: qari);
//       if (_ref.read(customPlaylistProvider).length > 0) {
//         setAyahIndex(_ref.read(customPlaylistProvider).ayahIndex);
//         await _audioPlayer
//             .play(_ref
//                 .read(customPlaylistProvider)
//                 .sources[_ref.read(customPlaylistProvider).ayahIndex])
//             .catchError((e) async => print(
//                 "catching exception -----> type ....... ${e.runtimeType.toString()} ....... "));
//         setPlay();
//       }
//     }
//   }

//   bool get isPlay => _isPlay;
//   bool get isAudioPlayerSet => _isAudioPlayerSet;
// }

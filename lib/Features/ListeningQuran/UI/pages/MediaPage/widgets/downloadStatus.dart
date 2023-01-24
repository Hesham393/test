import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../Providers/downloadSurahStateNotifier/downloadSurahStateNotifier.dart';
import '../../../../../readQuran/domain/entity/surah.dart';
import '../../../../../../materialColor/pallete.dart';
import '../../../../Providers/downloadSurahStateNotifier/downloadSurahStates.dart';
import '../../../../Providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../service/downloadStatus/dowloadStatus.dart';

class Download {
  final ChangeNotifierProvider<DownloadProgress> downloadProgress;
  final StateNotifierProvider<DownloadSurahStateNotifier, DownloadSurahState>
      downloadSurahStateNotifier;
  final String qari;
  final int surahNumber;

  Download({
    @required this.downloadProgress,
    @required this.qari,
    @required this.surahNumber,
    @required this.downloadSurahStateNotifier,
  });
}

class downloadStatus extends ConsumerStatefulWidget {
  final Surah surah;
  static final List<Download> downloads = [];

  downloadStatus({@required this.surah, Key key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _downloadStatusState();
  }
}

class _downloadStatusState extends ConsumerState<downloadStatus> {
  StateNotifierProvider<DownloadSurahStateNotifier, DownloadSurahState>
      downloadSurahStateNotifier;
  ChangeNotifierProvider<DownloadProgress> downloadProgress;

  bool isDownloaded;

  @override
  void initState() {
    isDownloaded = false;
    downloadProgress = ChangeNotifierProvider(
        (ref) => DownloadProgress(numberOfAyah: widget.surah.numberOfAyahs));
    downloadSurahStateNotifier = StateNotifierProvider(
      (ref) => DownloadSurahStateNotifier(
          repositoryImp: ref.read(listeningQuranRepositoryProvider)),
    );
    super.initState();
  }

  void onTap(DownloadProgress downProgress, String qari) async {
    if (!downProgress.errorStatus && !downProgress.getDownloadProgressStatus) {
      if (!isInDownloadedList(widget.surah.number, qari)) {
        downloadStatus.downloads.add(Download(
            downloadProgress: downloadProgress,
            downloadSurahStateNotifier: downloadSurahStateNotifier,
            qari: qari,
            surahNumber: widget.surah.number));
      }
      await ref
          .read(downloadSurahStateNotifier.notifier)
          .downloadSurahAudioFiles(widget.surah.number, qari, downProgress);
    }
  }

  bool isInDownloadedList(int surahNumber, String qari) {
    for (int i = 0; i < downloadStatus.downloads.length; i++) {
      if (qari == downloadStatus.downloads[i].qari &&
          downloadStatus.downloads[i].surahNumber == surahNumber) {
        return true;
      }
    }
    return false;
  }

  Download getDownload(int surahNumber, String qari) =>
      downloadStatus.downloads.firstWhere((download) =>
          qari == download.qari && surahNumber == download.surahNumber);

  void showSnackbarOfConnection() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: pallete.primaryColor,
        duration: const Duration(milliseconds: 850),
        content: Text(
          AppLocalizations.of(context).required_internet,
          textAlign: TextAlign.center,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final selectedQari = ref.watch(selectedQariProvider).getQari;
    return FutureBuilder<bool>(
        future: ref
            .watch(listeningQuranRepositoryProvider)
            .isDownloadedSurah(widget.surah.number, selectedQari.id),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == true
                ? const SizedBox(
                    width: 45,
                    child: Icon(Icons.play_arrow, color: pallete.primaryColor))
                : getDownloadButton(ref, selectedQari.id);
          }
          return const SizedBox();
        }));
  }

  Widget getDownloadButton(WidgetRef ref, String qari) {
    // print(downloadStatus.downloads.length);
    StateNotifierProvider<DownloadSurahStateNotifier, DownloadSurahState>
        downloadSurahNotifier;

    DownloadProgress downProgress;
    if (isInDownloadedList(widget.surah.number, qari)) {
      // print("In Download List");
      final dp = getDownload(widget.surah.number, qari).downloadProgress;
      downloadSurahNotifier =
          getDownload(widget.surah.number, qari).downloadSurahStateNotifier;
      downProgress = ref.watch(dp);
    } else {
      // print("nothing in Donwloads ");
      downProgress = ref.watch(downloadProgress);
      downloadSurahNotifier = downloadSurahStateNotifier;
    }

   
    final percent = (downProgress.totalReceived / downProgress.numberOfAyah);
    final status = DownloadStatusParam(
        downloadProgressStatus: downProgress.getDownloadProgressStatus,
        errorStatus: downProgress.errorStatus,
        fetchingStatus: downProgress.downloadAndFetchingStatus);

    return ProviderListener<DownloadSurahState>(
      provider: downloadSurahNotifier,
      onChange: (context, previous, value) {
        if (value is ConnectionFailureState) {
          print("+++++++++++++++ connection is failed ++++++++++");
          showSnackbarOfConnection();
        }
      },
      child: IconButton(
          onPressed: () => onTap(downProgress, qari),
          icon: getIcon(status, percent, qari: qari)),
    );
  }

  Widget getIcon(DownloadStatusParam param, double percent,
      {String qari = ""}) {
    if (param.downloadProgressStatus &&
        !param.errorStatus &&
        !param.fetchingStatus) {
      return CircularPercentIndicator(
        radius: 15,
        lineWidth: 5,
        progressColor: pallete.primaryColor,
        percent: percent > 1.0 ? 1.0 : percent,
      );
    }
    // else if (isInDownloadedList(widget.surah.number, qari)) {
    //   return CircularPercentIndicator(
    //     radius: 15,
    //     lineWidth: 5,
    //     progressColor: pallete.primaryColor,
    //     percent: per,
    //   );
    // }
    else if (percent >= 1) {
      return const SizedBox(
          width: 45,
          child: Icon(Icons.play_arrow, color: pallete.primaryColor));
    } else {
      return const CircleAvatar(
          radius: 10,
          backgroundColor: pallete.ayahColor,
          foregroundColor: pallete.primaryColor,
          backgroundImage: AssetImage(
            "assets/images/download.png",
          ));
    }
  }
}

class DownloadStatusParam {
  final bool downloadProgressStatus;
  final bool errorStatus;
  final bool fetchingStatus;
  DownloadStatusParam(
      {@required this.downloadProgressStatus,
      @required this.errorStatus,
      @required this.fetchingStatus});
}

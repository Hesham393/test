import 'package:flutter/material.dart';

class DownloadProgress with ChangeNotifier {
  final int numberOfAyah;
  int _totalRecevied = 1;
  bool _downloadProgressStatus = false;
  bool _donwloadAndFetchingStatus = false;
  bool _errorStatus = false;

  DownloadProgress({@required this.numberOfAyah});

  // void onReceiveProgress(int received, int total) {
  //   double percentage = received / total;
  //   print("percentage   ---- $percentage");
  //   if (percentage == 1.0) {
  //     _totalRecevied++;
  //     print(
  //         "DownloadProgress ($numberOfAyah): ${(_totalRecevied / numberOfAyah) * 100}%");
  //     notifyListeners();
  //   }
  // }

  void resetDownloadProgress() {
    _totalRecevied = 1;
    notifyListeners();
  }

  void increaseReceivedData() {
    _totalRecevied++;
    notifyListeners();
  }

  void errorhandling() {
    _errorStatus = true;
    notifyListeners();
  }

  void noError() {
    _errorStatus = false;
    notifyListeners();
  }

  void downloadAndFetchingCompeleted() {
    _donwloadAndFetchingStatus = true;
    notifyListeners();
  }

  void toggleDownloadProgress() {
    _downloadProgressStatus = !_downloadProgressStatus;
    notifyListeners();
  }

  bool get downloadAndFetchingStatus => _donwloadAndFetchingStatus;
  bool get getDownloadProgressStatus => _downloadProgressStatus;

  int get totalReceived => _totalRecevied;

  bool get errorStatus => _errorStatus;
}

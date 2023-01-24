import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_twekl_app/core/failure/failure.dart';

import '../model/bookmark_model.dart';

class BookmarkLocalSource {
  String p = "bookmarks.json";
  Future<String> get _localpath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return join(directory.path, p);
  }

  Future<File> get _localFile async {
    final path = await _localpath;

    File file = File(path);
    return file;
  }

  Future<void> writeBookmark(List<Bookmark> bookmarks) async {
    try {
      File file = await _localFile;

      final listOfBookmarks =
          List<Map<String, Object>>.generate(bookmarks.length, ((index) {
        return bookmarks[index].toJson();
      }));

      final String data = jsonEncode(listOfBookmarks);

      await file.writeAsString(data);
    } catch (e) {
      throw FileExceptionFailure();
    }
  }

  Future<List<Bookmark>> readBookmarks() async {
    try {
      File file = await _localFile;
      if (file.existsSync()) {
        final content = await file.readAsString();

        final List<dynamic> jsonData = jsonDecode(content);
        return List<Bookmark>.generate(jsonData.length, ((index) {
          return Bookmark.fromJson(jsonData[index]);
        }));
      }
     
    } catch (e) {
      print(e.toString());
      //throw FileExceptionFailure();
    }
  }

  // Future<void> removeBookmarks() async {
  //   File file = await _localFile;
  //   file.delete();
  // }
}

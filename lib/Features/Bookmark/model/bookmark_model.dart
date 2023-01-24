import 'package:flutter/material.dart';

enum BookmarkType {
  page,
  Ayah,
}

class Bookmark {
  final String dateTime;
  final String ayah;
  final int pageNumber;
  final String bookmarkType;
  final int surah;

  Bookmark(
      {@required this.dateTime,
      @required this.ayah,
      @required this.pageNumber,
      @required this.bookmarkType,
      this.surah});

  factory Bookmark.fromJson(Map<String, dynamic> data) {
    return Bookmark(
        dateTime: data['dateTime'],
        ayah: data['ayah'],
        pageNumber: data['pageNumber'],
        bookmarkType: data['bookmarkType'],
        surah: data["surah"] ?? -1);
  }

  Map<String, dynamic> toJson() {
    return {
      "dateTime": dateTime,
      "ayah": ayah,
      "pageNumber": pageNumber,
      "bookmarkType": bookmarkType,
      "surah": surah ?? -1
    };
  }
}

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:quran_twekl_app/Features/Bookmark/model/bookmark_model.dart';
import 'package:quran_twekl_app/Features/Bookmark/repository/bookmark_localsource.dart';
import '../../../core/failure/failure.dart';
import 'package:path_provider/path_provider.dart';

abstract class BookmarkRepository {
  Future<bool> insert_bookmark(List<Bookmark> bookmarks);
  Future<void> remove_bookmark(List<Bookmark> bookmarks);
  Future<bool> removeAll_bookmarks();
  Future<List<Bookmark>> all_bookmarks();
}

class BookmarkRepositoryImp extends BookmarkRepository {
  final BookmarkLocalSource bookmarkLocalSource;

  BookmarkRepositoryImp({@required this.bookmarkLocalSource});
  @override
  Future<List<Bookmark>> all_bookmarks() async {
    try {
      final bookmarks = await bookmarkLocalSource.readBookmarks();

      return bookmarks;
    } on FileExceptionFailure {
      throw FileExceptionFailure();
    }
  }

  @override
  Future<bool> insert_bookmark(List<Bookmark> bookmarks) async {
    try {
      await bookmarkLocalSource.writeBookmark(bookmarks);
      return true;
    } on FileExceptionFailure {
      return false;
    }
  }

  @override
  Future<bool> removeAll_bookmarks() {
    // TODO: implement removeAll_bookmarks
    throw UnimplementedError();
  }

  @override
  Future<bool> remove_bookmark(List<Bookmark> bookmarks) async {
    try {
      await bookmarkLocalSource.writeBookmark(bookmarks);
      return true;
    } on FileExceptionFailure {
      return false;
    }
  }
}

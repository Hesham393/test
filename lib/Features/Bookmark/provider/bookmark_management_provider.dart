import 'package:flutter/material.dart';
import 'package:quran_twekl_app/Features/readQuran/domain/entity/ayah.dart';
import '../model/bookmark_model.dart';
import '../repository/bookmark_repository.dart';

class BookmarkManagementNotifier extends ChangeNotifier {
  final BookmarkRepositoryImp repository;

  BookmarkManagementNotifier({@required this.repository});
  List<Bookmark> _list = [];

  Future<void> initialize(BookmarkRepositoryImp repository) async {
    // final repository =
    //     BookmarkRepositoryImp(bookmarkLocalSource: BookmarkLocalSource());

    final data = await repository.all_bookmarks();
    if (data != null) {
      _list.addAll(data);
      notifyListeners();
    }
  }

  Future<void> add(Bookmark bookmark) async {
    _list.add(bookmark);
    notifyListeners();
    await repository.insert_bookmark(_list);
  }

  Future<void> remove(Bookmark bookmark) async {
    _list.remove(bookmark);
    notifyListeners();
    await repository.remove_bookmark(_list);
  }

  Future<void> remove_pageBookmark(int page) async {
    _list.removeWhere((bookmark) =>
        bookmark.pageNumber == page &&
        bookmark.bookmarkType == BookmarkType.page.name);
    notifyListeners();
    await repository.remove_bookmark(_list);
  }

  Future<void> remove_ayahBookmark(Ayah ayah) async {
    _list.removeWhere((bookmark) =>
        bookmark.ayah ==
            (ayah.numberInSurah == 1 ? ayah.text.substring(38) : ayah.text) &&
        bookmark.pageNumber == ayah.page &&
        bookmark.bookmarkType == BookmarkType.Ayah.name);
    notifyListeners();
    await repository.remove_bookmark(_list);
  }

  bool isBookmarked(Ayah ayah) {
    return _list.any((bookmark) =>
        bookmark.ayah ==
            (ayah.numberInSurah == 1 ? ayah.text.substring(38) : ayah.text) &&
        bookmark.pageNumber == ayah.page &&
        bookmark.bookmarkType == BookmarkType.Ayah.name);
  }

  bool isBookmarkedPage(int page) {
    return _list.any((bookmark) =>
        bookmark.pageNumber == page &&
        bookmark.bookmarkType == BookmarkType.page.name);
  }

  List<Bookmark> get getAll => _list;
}

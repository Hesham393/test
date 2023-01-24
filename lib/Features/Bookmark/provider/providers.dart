import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/Bookmark/provider/bookmark_management_provider.dart';
import 'package:quran_twekl_app/Features/Bookmark/repository/bookmark_localsource.dart';

import '../../../main.dart';
import '../repository/bookmark_repository.dart';

final _bookmarkLocalSource = Provider(
  (ref) => BookmarkLocalSource(),
);

final _bookmarkRepository = Provider(
  (ref) => BookmarkRepositoryImp(
      bookmarkLocalSource: ref.read(_bookmarkLocalSource)),
);

final bookmarksProvider = FutureProvider(
  (ref) async => await ref.watch(_bookmarkRepository).all_bookmarks(),
);

final bookmarkManagementProvider =
    ChangeNotifierProvider(((ref) => bookmarkManagementNotifier));

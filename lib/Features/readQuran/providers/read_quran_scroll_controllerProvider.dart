import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadQuranScrollController {
  ItemScrollController _itemScrollController;
  bool _isMounted = false;
  void navigateToReadedAyah(int page) async {
    await _itemScrollController.scrollTo(
        index: page, duration: const Duration(milliseconds: 450));
  }

  Future<void> animatedToIndex(int index, Duration duration) async {
    if (isAttached && _itemScrollController != null) {
      await _itemScrollController.scrollTo(index: index, duration: duration);
    }
  }

  void setItemScrollController(ItemScrollController instance) {
    _itemScrollController = instance;
  }

  void setMount(bool mounted) {
    _isMounted = mounted;
  }

  bool get isMounted => _isMounted;
  bool get isAttached =>
      _itemScrollController != null && _itemScrollController.isAttached;
  ItemScrollController get getItemScrollController => _itemScrollController;
}

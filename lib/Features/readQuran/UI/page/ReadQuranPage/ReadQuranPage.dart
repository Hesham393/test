import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quran_twekl_app/Features/Bookmark/repository/bookmark_repository.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/readFlowDelegate.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/scrollFormDialogWT.dart';
import '../../../../ListeningQuran/UI/pages/AudioController/audioController.dart';
import '../../../../../core/constant/constants.dart' as c;
import '../../../../../core/sizeConfig/size_config.dart';
import 'appBar/SurahPointingAppBar.dart';
import 'appBar/juzNumberAppBar.dart';
import 'appBar/pagePointingAppBar.dart';
import 'read_quran_widget/customPageView.dart';
import 'read_quran_widget/readQuranDrawer.dart';
import '../home_page.dart';
import '../../widget/home_page/QuranAccessingSelection/selection_surah_list_home.dart';
import '../../../providers/providers.dart';
import '../../../../../materialColor/pallete.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../domain/entity/ayah.dart';

final scrollDirection =
    StateProvider<ScrollDirection>((ref) => ScrollDirection.idle);

class ReadQuranPage extends ConsumerStatefulWidget {
  static const String routeName = "/read-quran-page";
  @override
  ConsumerState<ReadQuranPage> createState() => _ReadQuranPageState();
}

class _ReadQuranPageState extends ConsumerState<ReadQuranPage>
    with SingleTickerProviderStateMixin {
  AudioController _audioController;
  ItemScrollController _scrollController;
  ScrollDirection _scrollDirection;
  ItemPositionsListener _itemPositionsListener;
  AnimationStatus _animationStatus;
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
  // AnimationController _menuAnimation;
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.expand,
    Icons.menu,
  ];

  List<Ayah> AyahsOfPage(int pageNumber, List<Ayah> list) {
    return list.where((ayah) => ayah.page == pageNumber).toList();
  }

  @override
  void initState() {
    _scrollController = ItemScrollController();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animationStatus = AnimationStatus.dismissed;
    _scrollDirection = ScrollDirection.reverse;
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -2.0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));
    _itemPositionsListener = ItemPositionsListener.create();

    _itemPositionsListener.itemPositions.addListener(scrollListener);

    _animation =
        Tween<double>(begin: 0, end: 100.0).animate(_animationController);

    _opacityAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
        reverseCurve: Curves.easeInOutBack);
    // Tween<double>(begin: 0, end: 1.0).animate(_animationController);
    //_animationController.forward();
    _animationController.addListener(changingAnimationState);
    _animationController.addStatusListener(animationStatusListener);
    _audioController = AudioController(
      opacityAnimation: _opacityAnimation,
      slideAnimation: _slideAnimation,
    );

    // _menuAnimation = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 300));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _itemPositionsListener.itemPositions.removeListener(scrollListener);
    _animationController.removeListener(changingAnimationState);
    _animationController.removeStatusListener(animationStatusListener);
    _animationController.dispose();
  }

  void changingAnimationState() {
    //ref.read(readQuranScrollControllerProvider).setMounted(mounted);
    if (mounted) {
      setState(() {});
    }
  }

  void animationStatusListener(AnimationStatus status) {
    _animationStatus = status;

    // print(_scrollDirection.toString());
    // if (_scrollDirection == ScrollDirection.forward) {
    //   _animationController.forward();
    // } else if (_scrollDirection == ScrollDirection.reverse) {
    //   _animationController.reverse();
    // }
  }

  void scrollListener() {
    final min = _itemPositionsListener.itemPositions.value
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    //print(min + 1);
    ref.read(quranPageIndexProvider.notifier).state = min + 1;

    // final max = _itemPositionsListener.itemPositions.value
    //     .where((ItemPosition position) => position.itemLeadingEdge < 1)
    //     .reduce((ItemPosition max, ItemPosition position) =>
    //         position.itemLeadingEdge > max.itemLeadingEdge ? position : max)
    //     .index;
    // print(max);
  }

  Future<void> animatedToIndex(int index, Duration duration) async {
    if (mounted) {
      await _scrollController.scrollTo(index: index, duration: duration);
    }
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: pallete.secondaryColor,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        // constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          // _updateMenu(icon);
          _animationController.status == AnimationStatus.completed
              ? _animationController.reverse()
              : _animationController.forward();
          if (icon == Icons.home) {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            ref.read(bottomNavigationIndexProvider.notifier).state = 0;
          } else if (icon == Icons.expand) {
            showDialog(
              context: context,
              builder: (context) {
                // ThemeConfig().init(context);
                // final textStyle = ThemeConfig.generalHeadline;
                return ScrollFormDialog(
                    animatedToIndex: ref
                        .read(readQuranScrollControllerProvider)
                        .animatedToIndex);
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeConfig().init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(readQuranScrollControllerProvider)
          .setItemScrollController(_scrollController);
      // animatedToIndex(3, const Duration(seconds: 55));
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: pallete.backgroundColor,
        // bottomNavigationBar: const customBottomNavigationBarHome(
        //   currentPage: 1,
        // ),
        // appBar: AppBar(
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.vertical(bottom: appBarRadius)),
        //   title: const pagePointingAppBar(),
        //   centerTitle: true,
        //   flexibleSpace: const LinearColor(),
        //   leadingWidth: 200,
        //   leading: const SurahPointingAppBar(),
        //   actions: const [
        //     juzNumberAppBar(),
        //   ],
        // ),
        drawer: ReadQuranDrawer(),
        body: PageStorage(bucket: bucketKey, child: _buildBody()),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) {
            final bottomNavigation = ref.watch(readQuranControllerFlag);
            // if (bottomNavigation) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: AnimatedContainer(
                curve: Curves.easeOut,

                duration: const Duration(milliseconds: 400),
                height: bottomNavigation ? kBottomNavigationBarHeight : 0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0.0, 5),
                        blurRadius: 20),
                    // BoxShadow(color: Colors.grey, offset: Offset(0.0, 5))
                  ],
                ),

                //  color:Colors.white,
                child: AudioController2(),
              ),
            );
            // }
            //  return const SizedBox();
          },
        ),
        floatingActionButton:

            // FadeTransition(
            // opacity: _opacityAnimation,
            // child:
            //  FloatingActionButton(
            //   mini: true,
            //   onPressed: () {
            // if (_animationController.value != 0) {
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       // ThemeConfig().init(context);
            //       // final textStyle = ThemeConfig.generalHeadline;

            //       return ScrollFormDialog(animatedToIndex: animatedToIndex);
            //     },
            //   );
            // }

            // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            // },
            // child:
            Flow(
                delegate: ReadFlowDelegate(
                    animation: _animationController, ctx: context),
                children: menuItems
                    .map<Widget>((icon) => flowMenuItem(icon))
                    .toList()),
      ),

      // ),
    );
  }

  Widget _buildBody() {
    final data = ref.watch(allAyahProvider);
    return data.when(
      data: (data) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          SizeConfig().init(context);

          return <Widget>[
            SliverAppBar(
              shape: c.appBarShape,
              title: const pagePointingAppBar(),
              flexibleSpace: Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.bottomStart,
                children: const [
                  LinearColor(),
                  // _audioController,
                ],
              ),

              centerTitle: true,
              floating: true,
              foregroundColor: Colors.white,
              pinned: true,
              snap: true,
              leadingWidth: 200,
              toolbarHeight: kToolbarHeight + 10,
              // expandedHeight: _animation.value,
              leading: const SurahPointingAppBar(),
              actions: const [
                juzNumberAppBar(),
              ],
            ),
          ];
        },
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            _scrollDirection = notification.direction;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(scrollDirection.notifier).state = _scrollDirection;
            });

            if (_scrollDirection == ScrollDirection.reverse &&
                _animationStatus == AnimationStatus.completed) {
              print("reverse animation has been executed");
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   _animationController.reverse();
              // });
            } else if (_scrollDirection == ScrollDirection.forward &&
                _animationStatus == AnimationStatus.dismissed) {
              print("forward animation has been executed");
              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //   _animationController.forward();
              // });
            }
            //print("notification : ${_scrollDirection.toString()}");
            return true;
          },
          child: ScrollablePositionedList.builder(
            key: const PageStorageKey<String>("QuranSelectedPage"),
            itemBuilder: (context, index) {
              return CustompageView(
                ayahs: AyahsOfPage(index + 1, data),
              );
            },
            itemCount: 604,
            itemScrollController: _scrollController,
            itemPositionsListener: _itemPositionsListener,
          ),
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class testAudioController extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  const testAudioController(
      {Key key,
      @required Animation<double> opacityAnimation,
      @required this.slideAnimation})
      : _opacityAnimation = opacityAnimation,
        super(key: key);

  final Animation<double> _opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(
          scale: _opacityAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      print("pressed back arrow");
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print("pressed play or pause button");
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print("pressed forward");
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//   Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
//         valueListenable: itemPositionsListener.itemPositions,
//         builder: (context, positions, child) {
//           int min;
//           int max;

//           if (positions.isNotEmpty) {
//             // Determine the first visible item by finding the item with the
//             // smallest trailing edge that is greater than 0.  i.e. the first
//             // item whose trailing edge in visible in the viewport.
//             min = positions
//                 .where((ItemPosition position) => position.itemTrailingEdge > 0)
//                 .reduce((ItemPosition min, ItemPosition position) =>
//                     position.itemTrailingEdge < min.itemTrailingEdge
//                         ? position
//                         : min)
//                 .index;
//             print(min);
//             // Determine the last visible item by finding the item with the
//             // greatest leading edge that is less than 1.  i.e. the last
//             // item whose leading edge in visible in the viewport.
//             max = positions
//                 .where((ItemPosition position) => position.itemLeadingEdge < 1)
//                 .reduce((ItemPosition max, ItemPosition position) =>
//                     position.itemLeadingEdge > max.itemLeadingEdge
//                         ? position
//                         : max)
//                 .index;
//             print(max);
//           }
//           return Container();

//         },
//       );

// using renderProxyBox for widget size

// typedef void OnWidgetSizeChange(Size size);

// class WidgetSizeRenderObject extends RenderProxyBox {
//   final OnWidgetSizeChange onSizeChange;

//   Size currentSize;

//   WidgetSizeRenderObject(this.onSizeChange);

//   @override
//   void performLayout() {
//     super.performLayout();

//     try {
//       Size newSize = child?.size;

//       if (newSize != null && currentSize != newSize) {
//         currentSize = newSize;

//         WidgetsBinding.instance?.addPostFrameCallback((_) {
//           onSizeChange(newSize);
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// class WidgetSizeOffsetWrapper extends SingleChildRenderObjectWidget {
//   final OnWidgetSizeChange onSizeChange;

//   const WidgetSizeOffsetWrapper({
//     Key key,
//     @required this.onSizeChange,
//     @required Widget child,
//   }) : super(key: key, child: child);

//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return WidgetSizeRenderObject(onSizeChange);
//   }
// }

// extension GlobalKeyExtension on GlobalKey {
//   Rect get globalPaintBounds {
//     final renderObject = currentContext?.findRenderObject();
//     final matrix = renderObject?.getTransformTo(null);

//     if (matrix != null && renderObject?.paintBounds != null) {
//       final rect = MatrixUtils.transformRect(matrix, renderObject.paintBounds);
//       return rect;
//     } else {
//       return null;
//     }
//   }
// }

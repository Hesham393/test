import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_twekl_app/Features/readQuran/UI/page/ReadQuranPage/read_quran_widget/selectScrollSpeedDropButton.dart';
import 'package:quran_twekl_app/Features/readQuran/providers/scrollspeedProvider.dart';
import 'package:quran_twekl_app/materialColor/pallete.dart';
import '../../../../../../core/responsiveness/responsive.dart';
import '../../../../../../core/sizeConfig/theme_configuration.dart';
import '../../../../providers/providers.dart';
import 'customCheckboxWT.dart';

class ScrollFormDialog extends ConsumerStatefulWidget {
  final Future<void> Function(int index, Duration duration) animatedToIndex;
  const ScrollFormDialog({
    @required this.animatedToIndex,
    Key key,
  }) : super(key: key);

  @override
  ConsumerState<ScrollFormDialog> createState() => _ScrollFormDialogState();
}

class _ScrollFormDialogState extends ConsumerState<ScrollFormDialog> {
  bool pageValue, surahValue;
  double _heightAnimation;
  FocusNode fromFocusNode;
  FocusNode toFocusNode;
  // FocusNode suahFocusNode;
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    pageValue = true;
    surahValue = false;

    fromFocusNode = FocusNode();
    toFocusNode = FocusNode();
    // suahFocusNode = FocusNode();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _heightAnimation = getPercentageOfResponsiveHeight(90, context);
    super.didChangeDependencies();
  }

  Future<void> animateTo(int from, int seconds, {int to = 604}) async {
    for (int i = from; i < to; i++) {
      await widget.animatedToIndex(i, Duration(seconds: seconds));
    }
  }

  // void onCheckboxChanged(bool val, String title) {
  //   if (title == "Surah" && !surahValue) {
  //     surahValue = val;
  //     pageValue ? pageValue = false : null;
  //     fromFocusNode.hasFocus ? fromFocusNode.unfocus() : null;
  //     toFocusNode.hasFocus ? toFocusNode.unfocus() : null;
  //     _pageController.clear();
  //     _toController.clear();
  //   } else if (title == "Page" && !pageValue) {
  //     pageValue = val;
  //     surahValue ? surahValue = false : null;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(quranPageIndexProvider);
    ThemeConfig().init(context);
    final descriptionStyle = ThemeConfig.generalHeadline;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230,
                        //  getPercentageOfResponsiveWidth(220, context),
                        child: TextFormField(
                          style: descriptionStyle.copyWith(fontSize: 13),
                          validator: (value) {
                            if (value.isEmpty) {
                              return null;
                            }
                            final index = int.tryParse(value);
                            if (index == null || index.isNegative) {
                              return "Please Enter correct number";
                            } else if (index < page) {
                              return "The number must be less than current Page";
                            }
                            return null;
                          },
                          focusNode: fromFocusNode,
                          controller: _pageController,
                          textInputAction: TextInputAction.done,
                          decoration: pageValue
                              ? InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: "Enter destination page number",
                                  labelStyle: descriptionStyle.copyWith(
                                      fontSize: 13, color: Colors.black54),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: pallete.secondaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: pallete.secondaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              : null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: getPercentageOfResponsiveHeight(15, context),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select scroll speed',
                            style: descriptionStyle,
                          ),
                          SizedBox(
                            width: getPercentageOfResponsiveWidth(8, context),
                          ),
                          selectScrollSpeedWT()
                        ],
                      ),
                    ]),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: pallete.secondaryColor,
                  textStyle: descriptionStyle,
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop();
                    // print("page : ${page}");
                    // print(
                    //     "next :${int.tryParse(_pageController.text)}");
                    final speed = ref.watch(scrollSpeedProvider);
                    int seconds = ScrollSpeeds.getDurationOfSpeed(speed);
                    if (_pageController.text.isEmpty) {
                       animateTo(page, seconds);
                   
                    }
                    final destination = int.tryParse(_pageController.text);

                    if (destination != null) {
                      await animateTo(page, seconds, to: destination);
                    }
                  }
                },
                child: const Text("Scroll")),
          ]),
        ),
      ),
    );
  }
}

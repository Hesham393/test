import 'package:flutter/material.dart';

// device break points max width and height
const int standardMobileWidthSize = 375;
const int standardMobileHeightSize = 667;

// default paddings
const double kDefalultHorizontalPadding = 15;
const double kDefalultVerticalPadding = 10;

getPercentageOfResponsiveWidth(double width, BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.width;
  final difference = deviceWidth / standardMobileWidthSize;

  return (width * difference);
}

getPercentageOfResponsiveHeight(double height, BuildContext context) {
  final deviceHeight = MediaQuery.of(context).size.height;
  final difference = deviceHeight / standardMobileHeightSize;
  return (height * difference);
}

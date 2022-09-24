import 'package:flutter/material.dart';
import 'package:recipe_book/ui/theme/style.dart';

ThemeData appTheme() {
  return ThemeData().copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      /// Heading 1
      /// Weight : Bold
      /// Size   : 16
      headline1: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: kPrimaryTextColor,
      ),

      /// Weight : Regular
      /// Size   : 14
      bodyText1: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: kPrimaryTextColor,
      ),

      /// Weight : Regular
      /// Size   : 12
      bodyText2: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: kPrimaryTextColor,
      ),

      /// Button Text
      /// Weight : Bold
      /// Size   : 14
      button: TextStyle(
        fontFamily: "OpenSans",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      // /// Caution/Overline
      // /// Weight : ExtraBold
      // /// Size   : 10
      // overline: TextStyle(
      //   fontFamily: "Mulish",
      //   fontSize: 10.sp,
      //   fontWeight: FontWeight.w800,
      //   color: kPrimaryTextColor,
      // ),

      // ///
      // /// Weight : Semibold
      // /// Size   : 10
      // subtitle1: TextStyle(
      //   fontFamily: "Mulish",
      //   fontSize: 10.sp,
      //   fontWeight: FontWeight.w600,
      //   color: kSecondaryTextColor,
      // ),
    ),
  );
}

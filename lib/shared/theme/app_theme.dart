import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/shared/theme/style.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData().copyWith(
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      /// Weight : Bold
      /// Size   : 20
      displayLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: kPrimaryTextColor,
      ),

      /// Weight : Bold
      /// Size   : 18
      displayMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: kPrimaryTextColor,
      ),

      /// Weight : Bold
      /// Size   : 16
      displaySmall: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: kPrimaryTextColor,
      ),

      /// Weight : Regular
      /// Size   : 14
      bodyLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: kPrimaryTextColor,
      ),

      /// Weight : Regular
      /// Size   : 12
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: kPrimaryTextColor,
      ),

      /// Button Text
      /// Weight : Bold
      /// Size   : 14
      labelLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}

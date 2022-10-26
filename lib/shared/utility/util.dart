import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class Util {
  static showSnackbar({required String msg, bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Info',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      icon: Icon(
        isError ? Icons.error_outline : Icons.info_outline,
        color: isError ? Colors.red : kPrimaryColor,
      ),
    );
  }

  static String formatCookingTime(String time) {
    try {
      String formattedTime = '';
      final splitTime = time.split(':');
      int hour = int.parse(splitTime[0]);
      int minute = int.parse(splitTime[1]);

      if (hour > 0) {
        formattedTime += '${hour.toString()} hr ';
      }

      if (minute > 0) {
        formattedTime += '${minute.toString()} min';
      }
      return formattedTime.isNotEmpty ? formattedTime : '-';
    } catch (e) {
      log(e.toString());
      return '-';
    }
  }

  static int passwordStrengthLevel(String password) {
    int strength = 0;
    RegExp lowercaseCheck = RegExp(r'[a-z]');
    RegExp uppercaseCheck = RegExp(r'[A-Z]');
    RegExp numberCheck = RegExp(r'[0-9]');
    RegExp symbolCheck = RegExp(r'[!"#$%&()*+,-./:;<=>?@[\]^_`{|}~]');

    if (password.isEmpty || password.length < 8) {
      strength = 0;
    } else {
      if (password.length >= 8) {
        strength++;
      }
      if (password.contains(lowercaseCheck)) {
        strength++;
      }
      if (password.contains(uppercaseCheck)) {
        strength++;
      }
      if (password.contains(numberCheck)) {
        strength++;
      }
      if (password.contains(symbolCheck)) {
        strength++;
      }
    }
    return strength;
  }
}

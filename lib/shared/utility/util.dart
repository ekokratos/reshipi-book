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
    } catch (_) {
      return '-';
    }
  }
}

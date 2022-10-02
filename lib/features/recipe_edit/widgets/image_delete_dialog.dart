import 'package:get/get.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';

showImageDeleteDialog(BuildContext context) {
  return showCustomDialog(
    context: context,
    title: 'Delete Image',
    content: 'Are you sure you want to delete the image?',
    icon: Icons.report_problem_outlined,
    iconColor: Colors.red,
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.blue),
        ),
      ),
      SolidButton(
        buttonColor: Colors.red,
        onPressed: () {
          Get.back();
        },
        text: 'Delete',
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}
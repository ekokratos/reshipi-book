import 'package:get/get.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';

showRemoveItemDialog({
  required BuildContext context,
  required String item,
  required VoidCallback? onRemove,
}) {
  return showCustomDialog(
    context: context,
    title: 'Remove $item',
    content: 'Are you sure you want to remove the $item?',
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
        onPressed: onRemove,
        text: 'Remove',
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

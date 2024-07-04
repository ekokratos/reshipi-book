import 'package:get/get.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';

showDeleteRecipeDialog({
  required BuildContext context,
  required VoidCallback? onDelete,
}) {
  return showCustomDialog(
    semanticLabel: 'Delete recipe dialog',
    context: context,
    title: 'Delete Recipe',
    content: 'Are you sure you want to delete this recipe?',
    icon: Icons.report_problem_outlined,
    iconColor: Colors.red,
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.blue),
        ),
      ),
      SolidButton(
        buttonColor: Colors.red,
        onPressed: onDelete,
        text: 'Remove',
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

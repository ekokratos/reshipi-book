import 'package:get/get.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';

showRemoveItemDialog({
  required BuildContext context,
  required String item,
  required VoidCallback? onRemove,
}) {
  final l10n = context.l10n;
  return showCustomDialog(
    semanticLabel: 'Remove $item dialog',
    context: context,
    title: l10n.recipeEditRemoveItemDialogTitle(item),
    content: l10n.recipeEditRemoveItemDialogDesc(item),
    icon: Icons.report_problem_outlined,
    iconColor: Colors.red,
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          l10n.cancel,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.blue),
        ),
      ),
      SolidButton(
        buttonColor: Colors.red,
        onPressed: onRemove,
        text: l10n.recipeEditRemoveItemDialogBtn,
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

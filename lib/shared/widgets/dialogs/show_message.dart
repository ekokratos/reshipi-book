import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/shared/models/dialog_message.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';

showMessage({
  required BuildContext context,
  required DialogMessage dialogMessage,
}) {
  return showCustomDialog(
    context: context,
    title: dialogMessage.title,
    content: dialogMessage.message,
    icon: Icons.info_outline,
    iconColor: kPrimaryColor,
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Ok',
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: kPrimaryColor),
        ),
      )
    ],
  );
}

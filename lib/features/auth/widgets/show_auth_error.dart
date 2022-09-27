import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:recipe_book/features/auth/models/auth_exception.dart';

showAuthError({
  required AuthException authException,
  required BuildContext context,
}) {
  return showCustomDialog(
    context: context,
    title: authException.title,
    content: authException.message,
    icon: Icons.error_outline,
    iconColor: Colors.red,
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

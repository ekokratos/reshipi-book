import 'package:auth_api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';

showAuthError({
  required AuthException authException,
  required BuildContext context,
}) {
  return showCustomDialog(
    semanticLabel: 'Authentication error dialog',
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
              .labelLarge!
              .copyWith(color: kPrimaryColor),
        ),
      ),
    ],
  );
}

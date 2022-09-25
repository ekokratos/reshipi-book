import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/dialogs/generic_dialog.dart';
import 'package:recipe_book/features/auth/repository/auth_exception.dart';

Future<void> showAuthError({
  required AuthException authException,
  required BuildContext context,
}) {
  return showGenericDialog(
    context: context,
    title: authException.title,
    content: authException.message,
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

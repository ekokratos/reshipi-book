import 'package:flutter/material.dart' show BuildContext;
import 'package:recipe_book/shared/widgets/dialogs/generic_dialog.dart';
import 'package:recipe_book/features/auth/repository/auth_exception.dart';

Future<void> showAuthError({
  required AuthException authException,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authException.title,
    content: authException.message,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}

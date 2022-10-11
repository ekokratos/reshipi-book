import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/l10n/localization.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showLogOutDialog(BuildContext context) {
  return showCustomDialog(
    context: context,
    title: Localization.of(context)!.logout,
    content: Localization.of(context)!.logout_message,
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text(
          Localization.of(context)!.cancel,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.blue),
        ),
      ),
      SolidButton(
        onPressed: () {
          context.read<AuthBloc>().add(const AuthEventLogOut());
          Get.back();
        },
        text: Localization.of(context)!.logout,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

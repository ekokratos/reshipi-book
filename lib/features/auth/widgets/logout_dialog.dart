import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/widgets/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showLogOutDialog(BuildContext context) {
  final l10n = context.l10n;
  return showCustomDialog(
    context: context,
    title: l10n.logOut,
    content: l10n.logOutConfirmation,
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
        onPressed: () {
          context.read<AuthBloc>().add(const AuthEventLogOut());
          Get.back();
        },
        text: l10n.logOut,
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

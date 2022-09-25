import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/shared/widgets/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
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
        onPressed: () {
          context.read<AuthBloc>().add(const AuthEventLogOut());
          Get.back();
        },
        text: 'Log out',
        padding: const EdgeInsets.all(0),
      ),
    ],
  );
}

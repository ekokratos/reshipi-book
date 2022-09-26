import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/dialogs/logout_dialog.dart';

AppBar commonAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline2,
    ),
    backgroundColor: Colors.white,
    foregroundColor: kPrimaryTextColor,
    elevation: 1.0,
    shadowColor: Colors.grey.shade50,
    actions: [
      IconButton(
        onPressed: () {
          showLogOutDialog(context);
        },
        icon: const Icon(
          Icons.logout,
        ),
      )
    ],
  );
}

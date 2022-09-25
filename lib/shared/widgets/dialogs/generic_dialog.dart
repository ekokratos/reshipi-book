import 'package:flutter/material.dart';

showGenericDialog({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget>? actions,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: actions,
      );
    },
  );
}

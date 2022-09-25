import 'package:flutter/material.dart';

showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget>? actions,
  IconData? icon,
  Color? iconColor,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
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

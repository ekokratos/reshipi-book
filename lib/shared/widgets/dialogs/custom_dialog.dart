import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget>? actions,
  required String semanticLabel,
  IconData? icon,
  Color? iconColor,
}) async {
  return await showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        semanticLabel: semanticLabel,
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
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: actions,
      );
    },
  );
}

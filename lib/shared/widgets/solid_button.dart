import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final EdgeInsetsGeometry? padding;
  const SolidButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: textColor ?? Colors.white),
      ),
    );
  }
}

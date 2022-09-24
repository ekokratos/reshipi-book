import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class SolidButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  const SolidButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.textColor,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      highlightColor: Colors.transparent,
      height: 44,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: buttonColor ?? kPrimaryColor,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(color: textColor ?? Colors.white),
      ),
    );
  }
}

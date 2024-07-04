import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final Color? color;

  const ClickableText({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor.withOpacity(0.2),
        highlightColor: kPrimaryColor.withOpacity(0.1),
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: color ?? kPrimaryColor,
                ),
          ),
        ),
      ),
    );
  }
}

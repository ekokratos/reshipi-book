import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final Color? color;

  const ClickableText({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: kPrimaryColor.withOpacity(0.2),
        highlightColor: kPrimaryColor.withOpacity(0.1),
        onTap: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: color ?? kPrimaryColor,
              ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_book/ui/theme/style.dart';

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
    return InkWell(
      splashColor: kPrimaryColor.withOpacity(0.2),
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: color ?? kPrimaryColor,
            ),
      ),
    );
  }
}

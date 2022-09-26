import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class CookingTimeWidget extends StatelessWidget {
  const CookingTimeWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: kPrimaryColor,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          '$time min',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/util.dart';

class CookingTimeWidget extends StatelessWidget {
  const CookingTimeWidget({
    super.key,
    required this.time,
  });

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
          Util.formatCookingTime(time),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

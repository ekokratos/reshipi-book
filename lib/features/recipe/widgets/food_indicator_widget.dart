import 'package:flutter/material.dart';
import 'package:recipes_api/recipes_api.dart';

class FoodIndicatorWidget extends StatelessWidget {
  const FoodIndicatorWidget({
    super.key,
    required this.recipeType,
  });

  final RecipeType recipeType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FoodIndicatorIcon(
          color: recipeType == RecipeType.nonveg ? Colors.red : Colors.green,
        ),
        const SizedBox(width: 5),
        Text(
          recipeType.value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class FoodIndicatorIcon extends StatelessWidget {
  const FoodIndicatorIcon({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.crop_square_sharp,
          color: color,
          size: 22,
        ),
        Icon(Icons.circle, color: color, size: 8),
      ],
    );
  }
}

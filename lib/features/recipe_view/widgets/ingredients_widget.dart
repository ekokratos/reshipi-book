import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({
    Key? key,
    this.ingredients,
  }) : super(key: key);

  final List<Ingredient>? ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients:',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 10),
        if (ingredients != null && ingredients!.isNotEmpty)
          ...List.generate(
            ingredients!.length,
            (index) => IngridientRow(ingredient: ingredients![index]),
          )
        else
          Text(
            'No Ingredients added',
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: Colors.grey.shade400,
                ),
          ),
      ],
    );
  }
}

class IngridientRow extends StatelessWidget {
  const IngridientRow({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: Text(
              ingredient.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

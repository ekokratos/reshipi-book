import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RecipeEditBloc, RecipeEditState, List<Ingredient>>(
      selector: (state) {
        return state.ingredients;
      },
      builder: (context, ingredients) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            if (ingredients.isNotEmpty)
              ...List.generate(
                ingredients.length,
                (index) => IngridientRow(ingredient: ingredients[index]),
              )
            else
              Text(
                'No Ingredients added',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.grey.shade400,
                    ),
              ),
          ],
        );
      },
    );
  }
}

class IngridientRow extends StatelessWidget {
  const IngridientRow({
    super.key,
    required this.ingredient,
  });

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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

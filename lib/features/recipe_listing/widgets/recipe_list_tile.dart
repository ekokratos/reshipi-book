import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe/view/recipe_screen.dart';
import 'package:recipe_book/features/recipe/widgets/cooking_time_widget.dart';
import 'package:recipe_book/features/recipe/widgets/food_indicator_widget.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_image_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({
    super.key,
    required this.recipe,
    required this.category,
  });

  final Recipe recipe;
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryColor.withOpacity(0.2),
      highlightColor: kPrimaryColor.withOpacity(0.1),
      onTap: () {
        Get.to(
          () => RecipeScreen(
            recipe: recipe,
            isNewRecipe: false,
            category: category,
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.5, 1),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: RecipeImageWidget(
                imageUrl: recipe.imageUrl,
                placeholderColor: Colors.white,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CookingTimeWidget(time: recipe.cookingTime),
                        FoodIndicatorWidget(recipeType: recipe.type),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/features/recipe_edit/views/recipe_edit_screen.dart';
import 'package:recipe_book/features/recipe_view/widgets/cooking_instructions_widget.dart';
import 'package:recipe_book/features/recipe_view/widgets/cooking_time_widget.dart';
import 'package:recipe_book/features/recipe_view/widgets/food_indicator_widget.dart';
import 'package:recipe_book/features/recipe_view/widgets/ingredients_widget.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_image_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({
    super.key,
    this.recipe,
    required this.isNewRecipe,
    required this.category,
  });

  final Recipe? recipe;
  final bool isNewRecipe;
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeEditBloc(
        recipesRepository: context.read<RecipesRepository>(),
        authRepository: context.read<AuthRepository>(),
        recipe: recipe,
        isNewRecipe: isNewRecipe,
        category: category,
      ),
      child: isNewRecipe ? const RecipeEditScreen() : const RecipeReadScreen(),
    );
  }
}

class RecipeReadScreen extends StatelessWidget {
  const RecipeReadScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<RecipeEditBloc, RecipeEditState, Recipe>(
        selector: (state) {
          return state.recipe;
        },
        builder: (context, recipe) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                leading: const BackButton(color: Colors.white),
                backgroundColor: kPrimaryColor,
                actions: [
                  Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          () => BlocProvider.value(
                            value: context.read<RecipeEditBloc>(),
                            child: RecipeEditScreen(
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      tooltip: 'Edit',
                      icon: const Icon(
                        Icons.edit,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  title: Text(
                    recipe.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  background: RecipeImageWidget(
                    imageUrl: recipe.imageUrl,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CookingTimeWidget(
                            time: recipe.cookingTime,
                          ),
                          FoodIndicatorWidget(
                            recipeType: recipe.type,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                size: 20,
                                color: Colors.blueGrey.shade200,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                recipe.category.value,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.description ?? 'No description',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 20),
                      const IngredientsWidget(),
                      const SizedBox(height: 20),
                      const CookingInstructionsWidget(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

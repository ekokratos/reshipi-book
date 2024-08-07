import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_book/features/recipe/view/recipe_edit_screen.dart';
import 'package:recipe_book/features/recipe/widgets/cooking_instructions_widget.dart';
import 'package:recipe_book/features/recipe/widgets/cooking_time_widget.dart';
import 'package:recipe_book/features/recipe/widgets/delete_recipe_dialog.dart';
import 'package:recipe_book/features/recipe/widgets/food_indicator_widget.dart';
import 'package:recipe_book/features/recipe/widgets/ingredients_widget.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_image_widget.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/util.dart';
import 'package:recipe_book/shared/widgets/expandable_fab.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
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
      create: (context) => RecipeBloc(
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RecipeBloc, RecipeState>(
      listenWhen: (previous, current) {
        return current.recipeDeleteStatus != previous.recipeDeleteStatus;
      },
      listener: (context, state) {
        if (state.recipeDeleteStatus == RecipeDeleteStatus.loading) {
          LoadingScreen.instance().show(
            context: context,
            text: l10n.recipeReadDeleteDialog,
          );
        } else {
          LoadingScreen.instance().hide();
        }

        if (state.recipeDeleteStatus == RecipeDeleteStatus.failure) {
          Util.showSnackbar(
            msg: l10n.recipeEditDeleteError,
            isError: true,
          );
        }
        if (state.recipeDeleteStatus == RecipeDeleteStatus.success) {
          Get.back();
          Util.showSnackbar(msg: l10n.recipeReadDeleteSuccess);
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: ExpandableFab(
            children: <ActionButton>[
              ActionButton(
                onPressed: () {
                  Get.to(
                    () => BlocProvider.value(
                      value: context.read<RecipeBloc>(),
                      child: RecipeEditScreen(
                        recipe: state.recipe,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  semanticLabel: 'Edit recipe',
                  Icons.edit,
                  color: Colors.blueAccent,
                ),
              ),
              ActionButton(
                onPressed: () {
                  showDeleteRecipeDialog(
                    context: context,
                    onDelete: () {
                      context
                          .read<RecipeBloc>()
                          .add(RecipeDeleted(recipe: state.recipe));
                      Get.back();
                    },
                  );
                },
                icon: const Icon(
                  semanticLabel: 'Delete recipe',
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor.withOpacity(0.7),
                  ),
                  margin: const EdgeInsets.only(left: 10),
                  child: const BackButton(color: Colors.white),
                ),
                backgroundColor: kPrimaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  title: Text(
                    state.recipe.title,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  background:
                      RecipeImageWidget(imageUrl: state.recipe.imageUrl),
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
                            time: state.recipe.cookingTime,
                          ),
                          FoodIndicatorWidget(
                            recipeType: state.recipe.type,
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
                                state.recipe.category.value,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.recipe.description ?? 'No description',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontStyle: FontStyle.italic),
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
          ),
        );
      },
    );
  }
}

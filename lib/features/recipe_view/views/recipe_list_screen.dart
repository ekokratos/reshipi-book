import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_book/features/recipe_view/views/recipe_screen.dart';
import 'package:recipe_book/features/recipe_view/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_list_tile.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/util.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'package:shimmer/shimmer.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key, required this.category});
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeViewBloc(
        recipesRepository: context.read<RecipesRepository>(),
        authRepository: context.read<AuthRepository>(),
      )..add(
          RecipeViewRecipesRequested(
            category: category,
          ),
        ),
      child: RecipeListView(category: category),
    );
  }
}

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key, required this.category});
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: category.value,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_new_recipe',
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Get.to(
            () => RecipeScreen(
              isNewRecipe: true,
              category: category,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: BlocConsumer<RecipeViewBloc, RecipeViewState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == RecipeViewStatus.failure) {
            Util.showSnackbar(
              msg:
                  'An error occurred while loading recipes. Please try refreshing.',
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.recipes.isEmpty) {
            if (state.status == RecipeViewStatus.loading) {
              return ListView(
                children: List.generate(7, (_) => const RecipeLoadingWidget()),
              );
            } else if (state.status != RecipeViewStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  'No Recipes found.',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.grey.shade400),
                ),
              );
            }
          }

          final recipies = state.recipes;

          return Column(
            children: [
              const SizedBox(height: 5),
              Text(
                'Pull down to refresh',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                itemCount: recipies.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return RecipeListTile(
                    recipe: recipies[index],
                    category: category,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RecipeLoadingWidget extends StatelessWidget {
  const RecipeLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kPrimaryColor.withOpacity(0.2),
      highlightColor: kPrimaryColor.withOpacity(0.1),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_listing/bloc/recipe_listing_bloc.dart';
import 'package:recipe_book/features/recipe/view/recipe_screen.dart';
import 'package:recipe_book/shared/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe_listing/widgets/recipe_list_tile.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/util.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'package:shimmer/shimmer.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key, required this.category});
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeListingBloc(
        recipesRepository: context.read<RecipesRepository>(),
        authRepository: context.read<AuthRepository>(),
      )..add(
          RecipeListingRecipesRequested(
            category: category,
          ),
        ),
      child: RecipeListView(category: category),
    );
  }
}

class RecipeListView extends StatelessWidget {
  RecipeListView({super.key, required this.category});
  final RecipeCategory category;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
          semanticLabel: 'Add new recipe',
          Icons.add,
          size: 28,
        ),
      ),
      body: BlocConsumer<RecipeListingBloc, RecipeListingState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == RecipeListingStatus.failure) {
            Util.showSnackbar(
              msg: l10n.recipeListError,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case RecipeListingStatus.loading:
              return ListView(
                children: List.generate(7, (_) => const RecipeLoadingWidget()),
              );

            case RecipeListingStatus.success:
              final recipies = state.recipes;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (recipies.isNotEmpty ||
                          _searchController.text.isNotEmpty)
                        CustomTextField(
                          controller: _searchController,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 24,
                          ),
                          label: l10n.recipeListSearch,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    context
                                        .read<RecipeListingBloc>()
                                        .add(const RecipeListingSearchClear());
                                  },
                                  child: const Icon(
                                    semanticLabel: 'click to clear search box',
                                    Icons.clear,
                                  ),
                                )
                              : null,
                          onChanged: (value) {
                            context
                                .read<RecipeListingBloc>()
                                .add(RecipeListingSearch(query: value));
                          },
                        ),
                      const SizedBox(height: 20),
                      if (recipies.isNotEmpty)
                        ListView.builder(
                          prototypeItem: RecipeListTile(
                            recipe: recipies.first,
                            category: category,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: recipies.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return RecipeListTile(
                              recipe: recipies[index],
                              category: category,
                            );
                          }),
                        )
                      else
                        Center(
                          child: Text(
                            l10n.recipeListNoRecipe,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Colors.grey.shade400),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            case RecipeListingStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.recipeListFailure,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Colors.grey.shade400),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.read<RecipeListingBloc>().add(
                              RecipeListingRecipesRequested(
                                category: category,
                              ),
                            );
                      },
                      icon: const Icon(Icons.replay),
                      label: Text(
                        'Retry',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class RecipeLoadingWidget extends StatelessWidget {
  const RecipeLoadingWidget({
    super.key,
  });

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

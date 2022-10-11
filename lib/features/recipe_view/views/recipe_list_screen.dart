import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_view/bloc/recipe_view_bloc.dart';
import 'package:recipe_book/features/recipe_view/views/recipe_screen.dart';
import 'package:recipe_book/features/recipe_view/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_list_tile.dart';
import 'package:recipe_book/l10n/localization.dart';
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
  RecipeListView({super.key, required this.category});
  final RecipeCategory category;
  final _searchController = TextEditingController();

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
              msg: Localization.of(context)!.error_occurred_load_recipe,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case RecipeViewStatus.loading:
              return ListView(
                children: List.generate(7, (_) => const RecipeLoadingWidget()),
              );

            case RecipeViewStatus.success:
              final recipies = state.recipes;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _searchController,
                        prefixIcon: const Icon(Icons.search, size: 24),
                        label: 'Search',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            context
                                .read<RecipeViewBloc>()
                                .add(const RecipeViewSearchClear());
                          },
                          child: const Icon(Icons.clear),
                        ),
                        onChanged: (value) {
                          context
                              .read<RecipeViewBloc>()
                              .add(RecipeViewSearch(query: value));
                        },
                      ),
                      const SizedBox(height: 20),
                      if (recipies.isNotEmpty)
                        ListView.builder(
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
                          child: Text(Localization.of(context)!.no_recipes,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.grey.shade400),
                          ),
                        )
                    ],
                  ),
                ),
              );
            case RecipeViewStatus.failure:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(Localization.of(context)!.oops,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.grey.shade400),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.read<RecipeViewBloc>().add(
                              RecipeViewRecipesRequested(
                                category: category,
                              ),
                            );
                      },
                      icon: const Icon(Icons.replay),
                      label: Text(
                        Localization.of(context)!.retry,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    )
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

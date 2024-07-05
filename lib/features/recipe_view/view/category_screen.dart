import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/recipe_view/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_category.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name =
        context.select((AuthBloc bloc) => bloc.state.user?.name ?? 'Chef');
    final l10n = context.l10n;
    return Scaffold(
      appBar:
          commonAppBar(context: context, title: l10n.categoryAppBarTitle(name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.displayLarge,
                  children: <TextSpan>[
                    const TextSpan(text: 'What would you like\nto '),
                    TextSpan(
                      text: 'prepare?',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: const [
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/breakfast.svg',
                      category: RecipeCategory.breakfast,
                    ),
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/meal.svg',
                      category: RecipeCategory.meal,
                    ),
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/snack.svg',
                      category: RecipeCategory.snack,
                    ),
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/dessert.svg',
                      category: RecipeCategory.dessert,
                    ),
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/beverage.svg',
                      category: RecipeCategory.beverage,
                    ),
                    RecipeCategoryWidget(
                      assetUrl: 'assets/svgs/other.svg',
                      category: RecipeCategory.other,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

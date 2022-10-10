import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/recipe_view/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_category.dart';
import 'package:recipe_book/l10n/localization.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context
        .select((AuthBloc bloc) => bloc.state.user?.displayName ?? 'Chef');
    return Scaffold(
      appBar: commonAppBar(context: context, title: 'Hi, $name'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline1,
                  children: <TextSpan>[
                    TextSpan(text: Localization.of(context)!.what_to_do),
                    TextSpan(
                      text: Localization.of(context)!.prepare,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: kPrimaryColor),
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
                  children: [
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.breakfast,
                      assetUrl: 'assets/svgs/breakfast.svg',
                      category: RecipeCategory.breakfast,
                    ),
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.lunch_dinner,
                      assetUrl: 'assets/svgs/meal.svg',
                      category: RecipeCategory.meal,
                    ),
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.snack,
                      assetUrl: 'assets/svgs/snack.svg',
                      category: RecipeCategory.snack,
                    ),
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.dessert,
                      assetUrl: 'assets/svgs/dessert.svg',
                      category: RecipeCategory.dessert,
                    ),
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.beverage,
                      assetUrl: 'assets/svgs/beverage.svg',
                      category: RecipeCategory.beverage,
                    ),
                    RecipeCategoryWidget(
                      text: Localization.of(context)!.others,
                      assetUrl: 'assets/svgs/other.svg',
                      category: RecipeCategory.other,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

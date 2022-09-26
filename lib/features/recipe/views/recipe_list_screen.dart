import 'package:flutter/material.dart';
import 'package:recipe_book/features/recipe/models/recipe.dart';
import 'package:recipe_book/features/recipe/widgets/common_app_bar.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_list_tile.dart';
import 'package:recipe_book/shared/theme/style.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key, required this.category});
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: category.value,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              return const RecipeListTile(
                imageUrl:
                    'https://www.licious.in/blog/wp-content/uploads/2020/12/Fried-Chicken-Wing.jpg',
                recipeName: 'Recipe name',
                recipeType: RecipeType.nonveg,
                time: '30',
              );
            }),
          ),
        ],
      ),
    );
  }
}

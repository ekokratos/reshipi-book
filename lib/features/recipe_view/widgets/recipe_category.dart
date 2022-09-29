import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_view/views/recipe_list_screen.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class RecipeCategoryWidget extends StatelessWidget {
  const RecipeCategoryWidget({
    super.key,
    required this.assetUrl,
    required this.text,
    required this.category,
  });

  final String assetUrl;
  final String text;
  final RecipeCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryColor.withOpacity(0.2),
      highlightColor: kPrimaryColor.withOpacity(0.1),
      onTap: () {
        Get.to(
          () => RecipeListScreen(
            category: category,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kPrimaryColor.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.1),
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              assetUrl,
              height: 120,
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

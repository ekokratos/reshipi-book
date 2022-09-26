import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/features/recipe/models/recipe.dart';
import 'package:recipe_book/shared/theme/style.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({
    Key? key,
    required this.imageUrl,
    required this.recipeName,
    required this.time,
    required this.recipeType,
  }) : super(key: key);

  final String imageUrl;
  final String recipeName;
  final String time;
  final RecipeType recipeType;
  // final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryColor.withOpacity(0.2),
      highlightColor: kPrimaryColor.withOpacity(0.1),
      onTap: () {},
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (_, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (_, __) => Image.asset(
                  'assets/images/default_recipe.png',
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  'assets/images/broken_image.png',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
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
                      recipeName,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$time min',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FoodIndicatorIcon(
                              color: recipeType == RecipeType.nonveg
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              recipeType.value,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    )
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

class FoodIndicatorIcon extends StatelessWidget {
  const FoodIndicatorIcon({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.crop_square_sharp,
          color: color,
          size: 22,
        ),
        Icon(Icons.circle, color: color, size: 8),
      ],
    );
  }
}

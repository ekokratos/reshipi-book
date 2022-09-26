import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/features/recipe/models/recipe.dart';
import 'package:recipe_book/features/recipe/widgets/cooking_time_widget.dart';
import 'package:recipe_book/features/recipe/widgets/food_indicator_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  onPressed: () {},
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
                'Recipe Name',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
              background: const RecipeImageWidget(),
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
                      const CookingTimeWidget(time: '30'),
                      const FoodIndicatorWidget(recipeType: RecipeType.nonveg),
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant,
                            size: 20,
                            color: Colors.blueGrey.shade200,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            RecipeCategory.meal.value,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description goes here... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar.',
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CookingInstructionsWidget extends StatelessWidget {
  const CookingInstructionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooking Instructions:',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 10),
        ...List.generate(
          8,
          (index) => CookingInstructionRow(step: (index + 1).toString()),
        )
      ],
    );
  }
}

class CookingInstructionRow extends StatelessWidget {
  const CookingInstructionRow({
    Key? key,
    required this.step,
  }) : super(key: key);
  final String step;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: kSecondaryTextColor),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipng elit, sed do eiusmod.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients:',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 10),
        ...List.generate(8, (index) => const IngridientRow()),
      ],
    );
  }
}

class IngridientRow extends StatelessWidget {
  const IngridientRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
          Flexible(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur elits.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class RecipeImageWidget extends StatelessWidget {
  const RecipeImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          'https://www.licious.in/blog/wp-content/uploads/2020/12/Fried-Chicken-Wing.jpg',
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
        color: Colors.black45,
        fit: BoxFit.contain,
      ),
      errorWidget: (_, __, ___) => Image.asset(
        'assets/images/broken_image.png',
        fit: BoxFit.contain,
        color: Colors.black45,
      ),
    );
  }
}

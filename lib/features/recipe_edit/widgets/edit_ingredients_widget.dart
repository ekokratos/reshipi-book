import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_view/views/recipe_screen.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_item_row.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_bottom_sheet.dart';
import 'package:recipe_book/features/recipe_edit/widgets/remove_item_dialog.dart';
import 'package:recipe_book/shared/theme/style.dart';

class EditIngredientsWidget extends StatelessWidget {
  const EditIngredientsWidget({
    Key? key,
    required TextEditingController ingredientController,
  })  : _ingredientController = ingredientController,
        super(key: key);

  final TextEditingController _ingredientController;

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
        ...List.generate(
          2,
          (index) => EditItemRow(
            item: const IngridientRow(),
            onEdit: () {
              _ingredientController.text =
                  'Lorem ipsum dolor sit amet, consec tetur elits';
              showIngredientBottomSheet();
            },
            onRemove: () {
              showRemoveItemDialog(
                context: context,
                item: 'Ingredient',
                onRemove: () {
                  Get.back();
                },
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: FloatingActionButton.small(
            backgroundColor: Colors.white,
            onPressed: () {
              _ingredientController.clear();
              showIngredientBottomSheet();
            },
            child: const Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  showIngredientBottomSheet() {
    Get.bottomSheet(
      RecipeBottomSheet(
        textController: _ingredientController,
        label: 'Ingredient',
        onPressed: () {
          /// Add to Bloc
          Get.back();
        },
      ),
    );
  }
}

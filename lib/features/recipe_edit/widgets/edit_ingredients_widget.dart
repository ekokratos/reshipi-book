import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_item_row.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_bottom_sheet.dart';
import 'package:recipe_book/features/recipe_edit/widgets/remove_item_dialog.dart';
import 'package:recipe_book/features/recipe_view/widgets/ingredients_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditIngredientsWidget extends StatelessWidget {
  EditIngredientsWidget({Key? key}) : super(key: key);

  final _ingredientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeEditBloc, RecipeEditState>(
      builder: (context, state) {
        final ingredients = state.ingredients;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            if (ingredients.isNotEmpty)
              ...List.generate(
                ingredients.length,
                (index) {
                  final ingredient = ingredients[index];
                  return EditItemRow(
                    item: IngridientRow(
                      ingredient: ingredient,
                    ),
                    onEdit: () {
                      _ingredientController.text = ingredient.name;
                      showIngredientBottomSheet(
                        context,
                        ingredient: ingredient,
                      );
                    },
                    onRemove: () {
                      showRemoveItemDialog(
                        context: context,
                        item: 'Ingredient',
                        onRemove: () {
                          context.read<RecipeEditBloc>().add(
                                RecipeEditIngredientDeleted(
                                  ingredient: ingredient,
                                ),
                              );
                          Get.back();
                        },
                      );
                    },
                  );
                },
              ),
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  _ingredientController.clear();
                  showIngredientBottomSheet(context);
                },
                child: const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showIngredientBottomSheet(BuildContext context, {Ingredient? ingredient}) {
    Get.bottomSheet(
      RecipeBottomSheet(
        formKey: _formKey,
        textController: _ingredientController,
        label: 'Ingredient',
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final name = _ingredientController.text;

            context.read<RecipeEditBloc>().add(
                  RecipeEditIngredientSaved(
                    ingredient: ingredient != null
                        ? ingredient.copyWith(name: name)
                        : Ingredient(name: name),
                  ),
                );
            Get.back();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_book/features/recipe/widgets/edit_item_row.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_bottom_sheet.dart';
import 'package:recipe_book/features/recipe/widgets/remove_item_dialog.dart';
import 'package:recipe_book/features/recipe/widgets/ingredients_widget.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditIngredientsWidget extends StatelessWidget {
  EditIngredientsWidget({super.key});

  final _ingredientController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        final ingredients = state.ingredients;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.recipeEditIngredientsTitle,
              style: Theme.of(context).textTheme.displayLarge,
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
                        item: l10n.recipeEditIngredient,
                        onRemove: () {
                          context.read<RecipeBloc>().add(
                                RecipeIngredientDeleted(
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
                  semanticLabel: 'Add new ingredient',
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
        label: context.l10n.recipeEditIngredient,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final name = _ingredientController.text;
            context.read<RecipeBloc>().add(
                  RecipeIngredientSaved(
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

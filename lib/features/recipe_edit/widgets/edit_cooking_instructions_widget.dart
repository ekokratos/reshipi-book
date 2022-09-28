import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_view/views/recipe_screen.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_item_row.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_bottom_sheet.dart';
import 'package:recipe_book/features/recipe_edit/widgets/remove_item_dialog.dart';
import 'package:recipe_book/shared/theme/style.dart';

class EditCookingInstructionsWidget extends StatelessWidget {
  const EditCookingInstructionsWidget({
    Key? key,
    required TextEditingController instructionController,
  })  : _instructionController = instructionController,
        super(key: key);

  final TextEditingController _instructionController;
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
          2,
          (index) => EditItemRow(
            item: CookingInstructionRow(
              step: (index + 1).toString(),
            ),
            onEdit: () {
              _instructionController.text =
                  'Lorem ipsum dolor sit amet, consectetur adipng elit, sed do eiusmod.';

              showInstructionBottomSheet();
            },
            onRemove: () {
              showRemoveItemDialog(
                context: context,
                item: 'Instruction',
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
            heroTag: 'ingredient_add',
            backgroundColor: Colors.white,
            onPressed: () {
              _instructionController.clear();
              showInstructionBottomSheet();
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

  showInstructionBottomSheet() {
    Get.bottomSheet(
      RecipeBottomSheet(
        textController: _instructionController,
        label: 'Instruction',
        onPressed: () {
          /// Add to Bloc
          Get.back();
        },
      ),
    );
  }
}

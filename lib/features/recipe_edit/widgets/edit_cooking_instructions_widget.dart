import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_item_row.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_bottom_sheet.dart';
import 'package:recipe_book/features/recipe_edit/widgets/remove_item_dialog.dart';
import 'package:recipe_book/features/recipe_view/widgets/cooking_instructions_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCookingInstructionsWidget extends StatelessWidget {
  EditCookingInstructionsWidget({Key? key}) : super(key: key);

  final _instructionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RecipeEditBloc, RecipeEditState, List<Instruction>>(
      selector: (state) {
        return state.instructions.sortOnStep();
      },
      builder: (context, instructions) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cooking Instructions:',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            if (instructions.isNotEmpty)
              ...List.generate(instructions.length, (index) {
                final instruction = instructions[index];
                return EditItemRow(
                  item: CookingInstructionRow(
                    instruction: Instruction(
                      name: instruction.name,
                      stepNumber: instruction.stepNumber,
                    ),
                  ),
                  onEdit: () {
                    _instructionController.text = instructions[index].name;

                    showInstructionBottomSheet(
                      context,
                      instruction: instruction,
                    );
                  },
                  onRemove: () {
                    showRemoveItemDialog(
                      context: context,
                      item: 'Instruction',
                      onRemove: () {
                        context.read<RecipeEditBloc>().add(
                              RecipeEditInstructionDeleted(
                                instruction: instruction,
                              ),
                            );
                        Get.back();
                      },
                    );
                  },
                );
              }),
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton.small(
                heroTag: 'ingredient_add',
                backgroundColor: Colors.white,
                onPressed: () {
                  _instructionController.clear();
                  showInstructionBottomSheet(
                    context,
                    stepNumber: instructions.length + 1,
                  );
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

  showInstructionBottomSheet(
    BuildContext context, {
    Instruction? instruction,
    int stepNumber = 0,
  }) {
    Get.bottomSheet(
      RecipeBottomSheet(
        formKey: _formKey,
        textController: _instructionController,
        label: 'Instruction',
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final name = _instructionController.text;
            context.read<RecipeEditBloc>().add(
                  RecipeEditInstructionSaved(
                    instruction: instruction != null
                        ? instruction.copyWith(name: name)
                        : Instruction(
                            name: name,
                            stepNumber: stepNumber,
                          ),
                  ),
                );
            Get.back();
          }
        },
      ),
    );
  }
}

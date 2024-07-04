import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class CookingInstructionsWidget extends StatelessWidget {
  const CookingInstructionsWidget({super.key});

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
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            if (instructions.isNotEmpty)
              ...List.generate(
                instructions.length,
                (index) => CookingInstructionRow(
                  instruction: instructions[index],
                ),
              )
            else
              Text(
                'No Instructions added',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.grey.shade400,
                    ),
              ),
          ],
        );
      },
    );
  }
}

class CookingInstructionRow extends StatelessWidget {
  const CookingInstructionRow({
    super.key,
    required this.instruction,
  });

  final Instruction instruction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            instruction.stepNumber.toString(),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: kSecondaryTextColor),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              instruction.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

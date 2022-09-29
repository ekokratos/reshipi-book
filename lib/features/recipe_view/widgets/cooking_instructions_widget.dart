import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipes_api/recipes_api.dart';

class CookingInstructionsWidget extends StatelessWidget {
  const CookingInstructionsWidget({
    Key? key,
    this.instructions,
  }) : super(key: key);

  final List<Instruction>? instructions;

  @override
  Widget build(BuildContext context) {
    final sortedInstructions = instructions.sortOnStep();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooking Instructions:',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 10),
        if (sortedInstructions.isNotEmpty)
          ...List.generate(
            sortedInstructions.length,
            (index) =>
                CookingInstructionRow(instruction: sortedInstructions[index]),
          )
        else
          Text(
            'No Instructions added',
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: Colors.grey.shade400,
                ),
          ),
      ],
    );
  }
}

class CookingInstructionRow extends StatelessWidget {
  const CookingInstructionRow({
    Key? key,
    required this.instruction,
  }) : super(key: key);

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
                .headline1!
                .copyWith(color: kSecondaryTextColor),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              instruction.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

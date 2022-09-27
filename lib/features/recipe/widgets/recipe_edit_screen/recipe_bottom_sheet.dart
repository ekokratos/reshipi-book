import 'package:flutter/material.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';

class RecipeBottomSheet extends StatelessWidget {
  const RecipeBottomSheet({
    Key? key,
    required this.label,
    this.onPressed,
    required this.textController,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: textController,
            label: label,
            maxLines: 2,
          ),
          const SizedBox(height: 15),
          SolidButton(
            onPressed: onPressed,
            text: 'Add',
          ),
        ],
      ),
    );
  }
}

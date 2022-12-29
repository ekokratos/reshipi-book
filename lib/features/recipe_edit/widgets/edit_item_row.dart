import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class EditItemRow extends StatelessWidget {
  const EditItemRow({
    Key? key,
    this.onEdit,
    this.onRemove,
    required this.item,
  }) : super(key: key);

  final VoidCallback? onEdit;
  final VoidCallback? onRemove;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: item,
        ),
        Row(
          children: [
            IconButton(
              alignment: Alignment.topCenter,
              onPressed: onEdit,
              icon: const Icon(
                semanticLabel: 'Edit',
                Icons.edit,
                color: kTextFieldPrefixColor,
                size: 22,
              ),
            ),
            IconButton(
              alignment: Alignment.topCenter,
              onPressed: onRemove,
              icon: const Icon(
                semanticLabel: 'Remove',
                Icons.close,
                color: Colors.red,
              ),
            )
          ],
        ),
      ],
    );
  }
}

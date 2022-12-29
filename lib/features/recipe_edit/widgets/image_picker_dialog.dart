import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';

Future<ImageSource?> showImagePickerDialog({
  required BuildContext context,
}) {
  return showDialog<ImageSource>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      return SimpleDialog(
        semanticLabel: 'Pick image dialog',
        titlePadding: const EdgeInsets.all(15),
        contentPadding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recipeEditImageDialogText,
              style: Theme.of(context).textTheme.headline2,
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                semanticLabel: 'Close dialog',
                Icons.close,
              ),
            )
          ],
        ),
        children: [
          PickerButton(
            icon: Icons.collections_outlined,
            text: l10n.recipeEditImageDialogGallery,
            onPressed: () {
              Get.back(result: ImageSource.gallery);
            },
          ),
          PickerButton(
            icon: Icons.camera_alt_outlined,
            text: l10n.recipeEditImageDialogCamera,
            onPressed: () {
              Get.back(result: ImageSource.camera);
            },
          )
        ],
      );
    },
  ).then(
    (imageSource) => imageSource,
  );
}

class PickerButton extends StatelessWidget {
  const PickerButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => kPrimaryColor),
      ),
      icon: Icon(
        icon,
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

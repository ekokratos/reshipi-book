import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/shared/theme/style.dart';

Future<ImageSource?> showImagePickerDialog({
  required BuildContext context,
}) {
  return showDialog<ImageSource>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        titlePadding: const EdgeInsets.all(15),
        contentPadding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pick image from:',
              style: Theme.of(context).textTheme.headline2,
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.close),
            )
          ],
        ),
        children: [
          PickerButton(
            icon: Icons.collections_outlined,
            text: 'Gallery',
            onPressed: () {
              Get.back(result: ImageSource.gallery);
            },
          ),
          PickerButton(
            icon: Icons.camera_alt_outlined,
            text: 'Camera',
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

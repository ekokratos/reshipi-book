import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/features/recipe_edit/widgets/image_delete_dialog.dart';
import 'package:recipe_book/features/recipe_edit/widgets/image_picker_dialog.dart';
import 'package:recipe_book/features/recipe_view/widgets/recipe_image_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';

class RecipeImageEditWidget extends StatefulWidget {
  const RecipeImageEditWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeImageEditWidget> createState() => _RecipeImageEditWidgetState();
}

class _RecipeImageEditWidgetState extends State<RecipeImageEditWidget> {
  final String imageUrl =
      // '';
      'https://www.licious.in/blog/wp-content/uploads/2020/12/Fried-Chicken-Wing.jpg';

  late ImagePicker _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: imageUrl.isNotEmpty
                  ? RecipeImageWidget(
                      imageUrl: imageUrl,
                    )
                  : Image.asset(
                      'assets/images/default_recipe.png',
                      color: Colors.white.withOpacity(0.6),
                    ),
            ),
          ),
          if (imageUrl.isEmpty)
            Positioned(
              right: 15,
              child: ImageButton(
                icon: Icons.add_a_photo_outlined,
                iconColor: kPrimaryColor,
                onPressed: () {},
              ),
            )
          else
            Positioned(
              right: 15,
              child: Row(
                children: [
                  ImageButton(
                    icon: Icons.edit_outlined,
                    iconColor: kPrimaryColor,
                    onPressed: () async {
                      final imageSource =
                          await showImagePickerDialog(context: context);
                      if (imageSource != null) {
                        XFile? image = await _imagePicker.pickImage(
                          source: imageSource,
                        );
                        if (image != null) {
                          log(image.path);
                          log(image.name);
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  ImageButton(
                    icon: Icons.delete_forever_outlined,
                    iconColor: Colors.red,
                    onPressed: () {
                      showImageDeleteDialog(context);
                    },
                  ),
                ],
              ),
            ),
          Positioned(
            top: 40,
            left: 20,
            child: ImageButton(
              icon: Icons.arrow_back,
              iconColor: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.8, 1.8),
            spreadRadius: 0.2,
            blurRadius: 0.5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
          size: 26,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

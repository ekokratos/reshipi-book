import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book/features/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_book/features/recipe/widgets/image_delete_dialog.dart';
import 'package:recipe_book/features/recipe/widgets/image_picker_dialog.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_image_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/util.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';

class RecipeImageEditWidget extends StatefulWidget {
  const RecipeImageEditWidget({
    super.key,
  });

  @override
  State<RecipeImageEditWidget> createState() => _RecipeImageEditWidgetState();
}

class _RecipeImageEditWidgetState extends State<RecipeImageEditWidget> {
  late ImagePicker _imagePicker;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: BlocConsumer<RecipeBloc, RecipeState>(
        listenWhen: (previous, current) {
          return previous.imageDeleteStatus != current.imageDeleteStatus;
        },
        listener: (context, state) {
          _imageDeleteStatus(context: context, status: state.imageDeleteStatus);
        },
        builder: (context, state) {
          final imageUrl = state.recipe.imageUrl;

          return Stack(
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
                  child: _pickedImage != null
                      ? Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                        )
                      : (imageUrl != null && imageUrl.isNotEmpty
                          ? RecipeImageWidget(
                              imageUrl: imageUrl,
                            )
                          : Image.asset(
                              'assets/images/default_recipe.png',
                              color: Colors.white.withOpacity(0.6),
                            )),
                ),
              ),

              ///Image add button
              if (imageUrl != null && imageUrl.isEmpty && _pickedImage == null)
                Positioned(
                  right: 15,
                  child: ImageButton(
                    semanticLabel: 'Pick image',
                    icon: Icons.add_a_photo_outlined,
                    iconColor: kPrimaryColor,
                    onPressed: () async {
                      final pickedImage = await _pickImage();
                      if (pickedImage != null) {
                        setState(() {
                          _pickedImage = pickedImage;
                        });
                        if (context.mounted) {
                          context.read<RecipeBloc>().add(
                                RecipeImageAdded(imageFile: pickedImage),
                              );
                        }
                      }
                    },
                  ),
                )
              else

                ///Image edit button
                Positioned(
                  right: 15,
                  child: Row(
                    children: [
                      ImageButton(
                        semanticLabel: 'Edit image',
                        icon: Icons.edit_outlined,
                        iconColor: kPrimaryColor,
                        onPressed: () async {
                          final pickedImage = await _pickImage();
                          if (pickedImage != null) {
                            setState(() {
                              _pickedImage = pickedImage;
                            });
                            if (context.mounted) {
                              context.read<RecipeBloc>().add(
                                    RecipeImageEdited(
                                      imageFile: pickedImage,
                                    ),
                                  );
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 10),

                      ///Image delete button
                      ImageButton(
                        semanticLabel: 'Delete image',
                        icon: Icons.delete_forever_outlined,
                        iconColor: Colors.red,
                        onPressed: () async {
                          bool? deleteImage = await showImageDeleteDialog(
                            context: context,
                          );
                          if (deleteImage ?? false) {
                            setState(() {
                              _pickedImage = null;
                            });
                            if (context.mounted) {
                              context
                                  .read<RecipeBloc>()
                                  .add(const RecipeImageDeleted());
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).viewPadding.top,
                left: 20,
                child: ImageButton(
                  semanticLabel: 'Back',
                  icon: Icons.arrow_back,
                  iconColor: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<File?> _pickImage() async {
    final imageSource = await showImagePickerDialog(context: context);
    File? pickedImage;
    if (imageSource != null) {
      XFile? image = await _imagePicker.pickImage(
        source: imageSource,
      );
      if (image != null) {
        pickedImage = File(image.path);
      }
    }
    return pickedImage;
  }

  void _imageDeleteStatus({
    required BuildContext context,
    required RecipeImageDeleteStatus status,
  }) {
    if (status == RecipeImageDeleteStatus.loading) {
      LoadingScreen.instance().show(
        context: context,
        text: 'Deleting image',
      );
    } else {
      LoadingScreen.instance().hide();
    }

    if (status == RecipeImageDeleteStatus.failure) {
      Util.showSnackbar(
        msg: 'An error occurred while deleting the image.',
        isError: true,
      );
    }

    if (status == RecipeImageDeleteStatus.success) {
      Util.showSnackbar(msg: 'Image deleted');
    }
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.icon,
    required this.iconColor,
    this.onPressed,
    required this.semanticLabel,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final String semanticLabel;

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
          semanticLabel: semanticLabel,
          color: iconColor,
          size: 26,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

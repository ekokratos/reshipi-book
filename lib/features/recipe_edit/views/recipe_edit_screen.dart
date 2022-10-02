import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe_edit/bloc/recipe_edit_bloc.dart';
import 'package:recipe_book/features/recipe_edit/widgets/custom_dropdown_field.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_cooking_instructions_widget.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_ingredients_widget.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_image_edit_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/time_formatter.dart';
import 'package:recipe_book/shared/utility/util.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeEditScreen extends StatefulWidget {
  const RecipeEditScreen({super.key, this.recipe});

  final Recipe? recipe;

  @override
  State<RecipeEditScreen> createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends State<RecipeEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _timeController;

  late RecipeType _recipeType;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe?.title);
    _descriptionController =
        TextEditingController(text: widget.recipe?.description);
    _timeController = TextEditingController(text: widget.recipe?.cookingTime);
    _recipeType = widget.recipe?.type ?? RecipeType.veg;
    imageUrl = widget.recipe?.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'create_new_recipe',
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            context.read<RecipeEditBloc>().add(
                  RecipeEditSaved(
                    recipe:
                        context.read<RecipeEditBloc>().state.recipe.copyWith(
                              title: _titleController.text,
                              cookingTime: _timeController.text,
                              type: _recipeType,
                              description: _descriptionController.text,
                              imageUrl: imageUrl,
                            ),
                  ),
                );
          }
        },
        backgroundColor: kPrimaryColor,
        label: Row(
          children: const [
            Icon(Icons.save_as_outlined),
            SizedBox(
              width: 5,
            ),
            Text('Save'),
          ],
        ),
      ),
      body: BlocConsumer<RecipeEditBloc, RecipeEditState>(
        listener: (context, state) {
          if (state.status == RecipeEditStatus.loading) {
            LoadingScreen.instance().show(
              context: context,
              text: 'Saving Recipe',
            );
          } else {
            LoadingScreen.instance().hide();
          }

          if (state.status == RecipeEditStatus.failure) {
            Util.showSnackbar(
              msg:
                  'An error occurred while saving the recipe. Please try again.',
              isError: true,
            );
          }

          if (state.status == RecipeEditStatus.success) {
            Get.back();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const RecipeImageEditWidget(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleField(titleController: _titleController),
                        const SizedBox(height: 20),
                        DescriptionField(
                          descriptionController: _descriptionController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: 'Category',
                          initialValue: state.category.value,
                          enabled: false,
                        ),
                        const SizedBox(height: 20),
                        RecipeTypeField(
                          recipeType: _recipeType,
                          onChanged: (RecipeType? newType) {
                            if (newType != null) {
                              setState(() {
                                _recipeType = newType;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        CookingTimeField(timeController: _timeController),
                        const SizedBox(height: 20),
                        EditIngredientsWidget(),
                        const SizedBox(height: 20),
                        EditCookingInstructionsWidget(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _titleController,
      label: 'Title',
      hintText: 'Recipe name',
      validator: (value) => Validation.validateNotEmpty(value),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    Key? key,
    required TextEditingController descriptionController,
  })  : _descriptionController = descriptionController,
        super(key: key);

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _descriptionController,
      label: 'Description',
      hintText: 'Type something about the recipe',
      maxLines: 4,
    );
  }
}

class CategoryField extends StatelessWidget {
  const CategoryField({
    Key? key,
    required this.category,
    required this.onChanged,
  }) : super(key: key);

  final RecipeCategory? category;
  final Function(RecipeCategory?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<RecipeCategory>(
      dropdownValue: category,
      label: 'Category',
      items: RecipeCategory.values
          .map<DropdownMenuItem<RecipeCategory>>((RecipeCategory category) {
        return DropdownMenuItem<RecipeCategory>(
          value: category,
          child: Text(
            category.value,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class RecipeTypeField extends StatelessWidget {
  const RecipeTypeField({
    Key? key,
    required this.recipeType,
    required this.onChanged,
  }) : super(key: key);

  final RecipeType? recipeType;
  final Function(RecipeType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<RecipeType>(
      dropdownValue: recipeType,
      label: 'Recipe Type',
      items: RecipeType.values
          .map<DropdownMenuItem<RecipeType>>((RecipeType type) {
        return DropdownMenuItem<RecipeType>(
          value: type,
          child: Text(
            type.value,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (recipeType) {
        if (recipeType == null) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

class CookingTimeField extends StatelessWidget {
  const CookingTimeField({
    Key? key,
    required TextEditingController timeController,
  })  : _timeController = timeController,
        super(key: key);

  final TextEditingController _timeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _timeController,
      label: 'Cooking time (hh:mm)',
      hintText: 'hh:mm',
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [TimeFormatter()],
      validator: (value) => Validation.validateNotEmpty(value),
    );
  }
}

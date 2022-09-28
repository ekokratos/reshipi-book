import 'package:flutter/material.dart';
import 'package:recipe_book/features/recipe_edit/models/enums.dart';
import 'package:recipe_book/features/recipe_edit/widgets/custom_dropdown_field.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_cooking_instructions_widget.dart';
import 'package:recipe_book/features/recipe_edit/widgets/edit_ingredients_widget.dart';
import 'package:recipe_book/features/recipe_edit/widgets/recipe_image_edit_widget.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/time_formatter.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';

class RecipeEditScreen extends StatefulWidget {
  const RecipeEditScreen({super.key});

  @override
  State<RecipeEditScreen> createState() => _RecipeEditScreenState();
}

class _RecipeEditScreenState extends State<RecipeEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();

  RecipeCategory? category = RecipeCategory.other;
  RecipeType? recipeType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'save_btn',
        onPressed: () {},
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RecipeImageEditWidget(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleField(titleController: _titleController),
                  const SizedBox(height: 20),
                  DescriptionField(
                    descriptionController: _descriptionController,
                  ),
                  const SizedBox(height: 20),
                  CategoryField(
                    category: category,
                    onChanged: (RecipeCategory? newCategory) {
                      setState(() {
                        category = newCategory;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  RecipeTypeField(
                    recipeType: recipeType,
                    onChanged: (RecipeType? newType) {
                      setState(() {
                        recipeType = newType;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  CookingTimeField(timeController: _timeController),
                  const SizedBox(height: 20),
                  EditIngredientsWidget(
                    ingredientController: _ingredientController,
                  ),
                  const SizedBox(height: 20),
                  EditCookingInstructionsWidget(
                    instructionController: _instructionController,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
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
      hintText: 'Recipe',
      validator: (value) => Validation.validateName(value),
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
      hintText: 'Type something about the recipe_view',
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
    );
  }
}

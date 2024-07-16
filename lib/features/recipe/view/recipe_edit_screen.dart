import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_book/features/recipe/widgets/custom_dropdown_field.dart';
import 'package:recipe_book/features/recipe/widgets/edit_cooking_instructions_widget.dart';
import 'package:recipe_book/features/recipe/widgets/edit_ingredients_widget.dart';
import 'package:recipe_book/features/recipe/widgets/recipe_image_edit_widget.dart';
import 'package:recipe_book/l10n/l10n.dart';
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

  late String imageUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe?.title);
    _descriptionController =
        TextEditingController(text: widget.recipe?.description);
    _timeController = TextEditingController(text: widget.recipe?.cookingTime);
    imageUrl = widget.recipe?.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<RecipeBloc, RecipeState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        _recipeEditStatus(context: context, status: state.status);
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'create_new_recipe',
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<RecipeBloc>().add(
                      RecipeSaved(
                        recipe: state.recipe.copyWith(
                          title: _titleController.text,
                          cookingTime: _timeController.text,
                          type: state.recipeType,
                          description: _descriptionController.text,
                        ),
                      ),
                    );
              }
            },
            backgroundColor: kPrimaryColor,
            label: Row(
              children: [
                const Icon(Icons.save_as_outlined),
                const SizedBox(width: 5),
                Text(l10n.recipeEditSaveBtn),
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
                          label: l10n.recipeEditCategoryField,
                          initialValue: state.category.value,
                          enabled: false,
                        ),
                        const SizedBox(height: 20),
                        Builder(
                          builder: (context) {
                            return RecipeTypeField(
                              recipeType: context.select(
                                (RecipeBloc value) => value.state.recipeType,
                              ),
                              onChanged: (RecipeType? newType) {
                                if (newType != null) {
                                  context.read<RecipeBloc>().add(
                                        RecipeTypeChanged(recipeType: newType),
                                      );
                                }
                              },
                            );
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
          ),
        );
      },
    );
  }

  void _recipeEditStatus({
    required BuildContext context,
    required RecipeStatus status,
  }) {
    final l10n = context.l10n;
    if (status == RecipeStatus.loading) {
      LoadingScreen.instance().show(
        context: context,
        text: l10n.recipeEditSavingDialog,
      );
    } else {
      LoadingScreen.instance().hide();
    }

    if (status == RecipeStatus.failure) {
      Util.showSnackbar(
        msg: l10n.recipeEditSavingError,
        isError: true,
      );
    }

    if (status == RecipeStatus.success) {
      Get.back();
    }
  }
}

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CustomTextField(
      controller: _titleController,
      label: l10n.recipeEditTitleField,
      hintText: l10n.recipeEditTitleHint,
      validator: (value) => Validation.validateNotEmpty(value),
    );
  }
}

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CustomTextField(
      controller: _descriptionController,
      label: l10n.recipeEditDescField,
      hintText: l10n.recipeEditDescHint,
      maxLines: 4,
    );
  }
}

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.category,
    required this.onChanged,
  });

  final RecipeCategory? category;
  final Function(RecipeCategory?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<RecipeCategory>(
      dropdownValue: category,
      label: context.l10n.recipeEditCategoryField,
      items: RecipeCategory.values
          .map<DropdownMenuItem<RecipeCategory>>((RecipeCategory category) {
        return DropdownMenuItem<RecipeCategory>(
          value: category,
          child: Text(
            category.value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class RecipeTypeField extends StatelessWidget {
  const RecipeTypeField({
    super.key,
    required this.recipeType,
    required this.onChanged,
  });

  final RecipeType? recipeType;
  final Function(RecipeType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<RecipeType>(
      dropdownValue: recipeType,
      label: context.l10n.recipeEditRecipeTypeField,
      items: RecipeType.values
          .map<DropdownMenuItem<RecipeType>>((RecipeType type) {
        return DropdownMenuItem<RecipeType>(
          value: type,
          child: Text(
            type.value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
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
    super.key,
    required TextEditingController timeController,
  }) : _timeController = timeController;

  final TextEditingController _timeController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _timeController,
      label: context.l10n.recipeEditTimeField,
      hintText: 'hh:mm',
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [TimeFormatter()],
      validator: (value) => Validation.validateNotEmpty(value),
    );
  }
}

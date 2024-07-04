part of 'recipe_edit_bloc.dart';

enum RecipeEditStatus { initial, loading, success, failure }

enum RecipeDeleteStatus { initial, loading, success, failure }

enum RecipeImageDeleteStatus { initial, loading, success, failure }

@immutable
class RecipeEditState extends Equatable {
  const RecipeEditState({
    this.status = RecipeEditStatus.initial,
    required this.recipe,
    required this.isNewRecipe,
    required this.ingredients,
    required this.instructions,
    required this.category,
    this.imageFile,
    this.recipeDeleteStatus = RecipeDeleteStatus.initial,
    this.recipeImageEdited = false,
    this.imageDeleteStatus = RecipeImageDeleteStatus.initial,
  });

  final RecipeEditStatus status;
  final RecipeDeleteStatus recipeDeleteStatus;
  final Recipe recipe;
  final bool isNewRecipe;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final RecipeCategory category;
  final File? imageFile;
  final bool recipeImageEdited;
  final RecipeImageDeleteStatus imageDeleteStatus;

  RecipeEditState copyWith({
    RecipeEditStatus? status,
    RecipeDeleteStatus? recipeDeleteStatus,
    Recipe? recipe,
    bool? isNewRecipe,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
    RecipeCategory? category,
    File? imageFile,
    bool? recipeImageEdited,
    RecipeImageDeleteStatus? imageDeleteStatus,
  }) {
    return RecipeEditState(
      status: status ?? this.status,
      recipeDeleteStatus: recipeDeleteStatus ?? this.recipeDeleteStatus,
      recipe: recipe ?? this.recipe,
      isNewRecipe: isNewRecipe ?? this.isNewRecipe,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      imageFile: imageFile ?? this.imageFile,
      recipeImageEdited: recipeImageEdited ?? this.recipeImageEdited,
      imageDeleteStatus: imageDeleteStatus ?? this.imageDeleteStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        recipe,
        isNewRecipe,
        ingredients,
        instructions,
        category,
        imageFile,
        imageDeleteStatus,
        recipeDeleteStatus,
      ];
}

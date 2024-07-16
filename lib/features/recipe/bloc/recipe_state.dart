part of 'recipe_bloc.dart';

enum RecipeStatus { initial, loading, success, failure }

enum RecipeDeleteStatus { initial, loading, success, failure }

enum RecipeImageDeleteStatus { initial, loading, success, failure }

@immutable
class RecipeState extends Equatable {
  const RecipeState({
    this.status = RecipeStatus.initial,
    required this.recipe,
    required this.isNewRecipe,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.recipeType,
    this.imageFile,
    this.recipeDeleteStatus = RecipeDeleteStatus.initial,
    this.recipeImageEdited = false,
    this.imageDeleteStatus = RecipeImageDeleteStatus.initial,
  });

  final RecipeStatus status;
  final RecipeDeleteStatus recipeDeleteStatus;
  final Recipe recipe;
  final bool isNewRecipe;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final RecipeCategory category;
  final File? imageFile;
  final bool recipeImageEdited;
  final RecipeImageDeleteStatus imageDeleteStatus;
  final RecipeType recipeType;

  RecipeState copyWith({
    RecipeStatus? status,
    RecipeDeleteStatus? recipeDeleteStatus,
    Recipe? recipe,
    bool? isNewRecipe,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
    RecipeCategory? category,
    File? imageFile,
    bool? recipeImageEdited,
    RecipeImageDeleteStatus? imageDeleteStatus,
    RecipeType? recipeType,
  }) {
    return RecipeState(
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
      recipeType: recipeType ?? this.recipeType,
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

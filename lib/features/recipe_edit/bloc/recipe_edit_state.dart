part of 'recipe_edit_bloc.dart';

enum RecipeEditStatus { initial, loading, success, failure }

@immutable
class RecipeEditState extends Equatable {
  const RecipeEditState({
    this.status = RecipeEditStatus.initial,
    required this.recipe,
    required this.isNewRecipe,
    required this.ingredients,
    required this.instructions,
    required this.category,
  });

  final RecipeEditStatus status;
  final Recipe recipe;
  final bool isNewRecipe;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final RecipeCategory category;

  RecipeEditState copyWith({
    RecipeEditStatus? status,
    Recipe? recipe,
    bool? isNewRecipe,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
    RecipeCategory? category,
  }) {
    return RecipeEditState(
      status: status ?? this.status,
      recipe: recipe ?? this.recipe,
      isNewRecipe: isNewRecipe ?? this.isNewRecipe,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props =>
      [status, recipe, isNewRecipe, ingredients, instructions, category];
}

/*
class RecipeEditState extends Equatable {
  const RecipeEditState({
    this.status = RecipeEditStatus.initial,
    required this.recipe,
    required this.isNewRecipe,
    required this.ingredients,
    required this.instructions,

    // List<Ingredient>? ingredients,
    // List<Instruction>? instructions,
  });
  //  : ingredients = recipe.ingredients,
  //       instructions = recipe.instructions;

  final RecipeEditStatus status;
  final Recipe recipe;
  final bool isNewRecipe;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;

  RecipeEditState copyWith({
    RecipeEditStatus? status,
    Recipe? recipe,
    bool? isNewRecipe,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
  }) {
    return RecipeEditState(
      status: status ?? this.status,
      recipe: recipe ?? this.recipe,
      isNewRecipe: isNewRecipe ?? this.isNewRecipe,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        recipe,
        ingredients,
      ];
}

class RecipeEditStateInEditView extends RecipeEditState {
  const RecipeEditStateInEditView({
    RecipeEditStatus status = RecipeEditStatus.initial,
    required Recipe recipe,
    required bool isNewRecipe,
    required List<Ingredient> ingredients,
    required List<Instruction> instructions,
  }) : super(
          recipe: recipe,
          isNewRecipe: isNewRecipe,
          ingredients: ingredients,
          instructions: instructions,
        );
  // {
  //   log('isNewRecipe: $isNewRecipe');
  //   log('recipe: ${recipe.toString()}');
  // }

  // @override
  // RecipeEditStateInEditView copyWith({
  //   RecipeEditStatus? status,
  //   Recipe? recipe,
  //   bool? isNewRecipe,
  //   List<Ingredient>? ingredients,
  //   List<Instruction>? instructions,
  // }) {
  //   return RecipeEditStateInEditView(
  //     status: status ?? this.status,
  //     recipe: recipe ?? this.recipe,
  //     isNewRecipe: isNewRecipe ?? this.isNewRecipe,
  //     ingredients: ingredients ?? this.ingredients,
  //     instructions: instructions ?? this.instructions,
  //   );
  // }
}

class RecipeEditStateInReadView extends RecipeEditState {
  RecipeEditStateInReadView({
    required bool isNewRecipe,
    required Recipe recipe,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
  }) : super(
          recipe: recipe,
          isNewRecipe: isNewRecipe,
          ingredients: ingredients ?? [],
          instructions: instructions ?? [],
        );
  // {

  //   log('isNewRecipe: $isNewRecipe');
  //   log('recipe: ${recipe.toString()}');
  // }

}
*/

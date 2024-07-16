part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

///Recipe related events
///
///Events: [RecipeSaved], [RecipeDeleted]
class RecipeSaved extends RecipeEvent {
  const RecipeSaved({
    required this.recipe,
    this.imageFile,
  });
  final Recipe recipe;
  final File? imageFile;
}

class RecipeDeleted extends RecipeEvent {
  const RecipeDeleted({required this.recipe});
  final Recipe recipe;
}

///Ingredient Related events
///
///Events: [RecipeIngredientSaved] and [RecipeIngredientDeleted]
class RecipeIngredientSaved extends RecipeEvent {
  const RecipeIngredientSaved({required this.ingredient});
  final Ingredient ingredient;
}

class RecipeIngredientDeleted extends RecipeEvent {
  const RecipeIngredientDeleted({required this.ingredient});
  final Ingredient ingredient;
}

///Cooking Instruction Related events
///
///Events: [RecipeInstructionSaved] and [RecipeInstructionDeleted]
class RecipeInstructionSaved extends RecipeEvent {
  const RecipeInstructionSaved({required this.instruction});
  final Instruction instruction;
}

class RecipeInstructionDeleted extends RecipeEvent {
  const RecipeInstructionDeleted({required this.instruction});
  final Instruction instruction;
}

///Image Related events
///
///Events: [RecipeImageAdded], [RecipeImageEdited] and [RecipeImageDeleted]
class RecipeImageAdded extends RecipeEvent {
  const RecipeImageAdded({required this.imageFile});
  final File imageFile;
}

class RecipeImageEdited extends RecipeEvent {
  const RecipeImageEdited({required this.imageFile});
  final File imageFile;
}

class RecipeImageDeleted extends RecipeEvent {
  const RecipeImageDeleted();
}

class RecipeTypeChanged extends RecipeEvent {
  const RecipeTypeChanged({required this.recipeType});
  final RecipeType recipeType;
}

part of 'recipe_edit_bloc.dart';

abstract class RecipeEditEvent extends Equatable {
  const RecipeEditEvent();

  @override
  List<Object> get props => [];
}

class RecipeEditSaved extends RecipeEditEvent {
  const RecipeEditSaved({required this.recipe});
  final Recipe recipe;
}

///Ingredient Related events
///
///Events: [RecipeEditIngredientSaved] and [RecipeEditIngredientDeleted]
class RecipeEditIngredientSaved extends RecipeEditEvent {
  const RecipeEditIngredientSaved({required this.ingredient});
  final Ingredient ingredient;
}

class RecipeEditIngredientDeleted extends RecipeEditEvent {
  const RecipeEditIngredientDeleted({required this.ingredient});
  final Ingredient ingredient;
}

///Cooking Instruction Related events
///
///Events: [RecipeEditInstructionSaved] and [RecipeEditInstructionDeleted]
class RecipeEditInstructionSaved extends RecipeEditEvent {
  const RecipeEditInstructionSaved({required this.instruction});
  final Instruction instruction;
}

class RecipeEditInstructionDeleted extends RecipeEditEvent {
  const RecipeEditInstructionDeleted({required this.instruction});
  final Instruction instruction;
}

///Image Related events
///
///Events: [RecipeEditImageAdded], [RecipeEditImageEdited] and [RecipeEditImageDeleted]
class RecipeEditImageAdded extends RecipeEditEvent {
  const RecipeEditImageAdded();
}

class RecipeEditImageEdited extends RecipeEditEvent {
  const RecipeEditImageEdited();
}

class RecipeEditImageDeleted extends RecipeEditEvent {
  const RecipeEditImageDeleted();
}

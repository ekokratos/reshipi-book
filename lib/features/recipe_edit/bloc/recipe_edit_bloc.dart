import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'package:collection/collection.dart';

part 'recipe_edit_event.dart';
part 'recipe_edit_state.dart';

class RecipeEditBloc extends Bloc<RecipeEditEvent, RecipeEditState> {
  RecipeEditBloc({
    required RecipesRepository recipesRepository,
    required AuthRepository authRepository,
    required bool isNewRecipe,
    Recipe? recipe,
    required RecipeCategory category,
  })  : _recipesRepository = recipesRepository,
        super(
          RecipeEditState(
            isNewRecipe: isNewRecipe,
            recipe: recipe ??
                Recipe.empty(userId: authRepository.currentUser?.uid ?? ''),
            ingredients: [...recipe?.ingredients ?? []],
            instructions: [...recipe?.instructions ?? []],
            category: category,
          ),
        ) {
    on<RecipeEditIngredientSaved>(_onIngredientSaved);
    on<RecipeEditIngredientDeleted>(_onIngredientDeleted);
    on<RecipeEditInstructionSaved>(_onInstructionSaved);
    on<RecipeEditInstructionDeleted>(_onInstructionDeleted);
    on<RecipeEditSaved>(_onRecipeSaved);
  }

  final RecipesRepository _recipesRepository;

  void _onIngredientSaved(
    RecipeEditIngredientSaved event,
    Emitter<RecipeEditState> emit,
  ) {
    final ingredients = List<Ingredient>.from(state.ingredients);
    final ingredient = event.ingredient;

    final ingredientIndex =
        ingredients.indexWhere((i) => i.id == ingredient.id);

    if (ingredientIndex >= 0) {
      ingredients[ingredientIndex] = ingredient;
    } else {
      ingredients.add(ingredient);
    }

    emit(state.copyWith(ingredients: ingredients));
  }

  void _onIngredientDeleted(
    RecipeEditIngredientDeleted event,
    Emitter<RecipeEditState> emit,
  ) {
    final ingredients = List<Ingredient>.from(state.ingredients);
    final ingredient = event.ingredient;

    final ingredientIndex =
        ingredients.indexWhere((i) => i.id == ingredient.id);

    if (ingredientIndex >= 0) {
      ingredients.removeAt(ingredientIndex);
    }
    emit(state.copyWith(ingredients: List.of(ingredients)));
  }

  void _onInstructionSaved(
    RecipeEditInstructionSaved event,
    Emitter<RecipeEditState> emit,
  ) {
    final instructions = List<Instruction>.from(state.instructions);
    final instruction = event.instruction;

    final instructionIndex =
        instructions.indexWhere((i) => i.id == instruction.id);

    if (instructionIndex >= 0) {
      instructions[instructionIndex] = instruction;
    } else {
      instructions.add(instruction);
    }

    emit(state.copyWith(instructions: instructions));
  }

  void _onInstructionDeleted(
    RecipeEditInstructionDeleted event,
    Emitter<RecipeEditState> emit,
  ) {
    final instructions = List<Instruction>.from(state.instructions);
    final instruction = event.instruction;

    final instructionIndex =
        instructions.indexWhere((i) => i.id == instruction.id);

    if (instructionIndex >= 0) {
      instructions.removeAt(instructionIndex);
    }

    // Reassigning the steps
    final reassignedInstructions = instructions
        .mapIndexed(
          (index, instruction) => instruction.copyWith(
            stepNumber: index + 1,
          ),
        )
        .toList();

    emit(state.copyWith(instructions: reassignedInstructions));
  }

  _onRecipeSaved(
    RecipeEditSaved event,
    Emitter<RecipeEditState> emit,
  ) async {
    emit(state.copyWith(status: RecipeEditStatus.loading));
    try {
      log(event.recipe.toString());
      await _recipesRepository.saveRecipe(
        recipe: event.recipe.copyWith(
          ingredients: state.ingredients,
          instructions: state.instructions,
          category: state.category,
        ),
      );

      emit(
        state.copyWith(
          status: RecipeEditStatus.success,
          recipe: event.recipe,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RecipeEditStatus.failure));
    }
  }
}

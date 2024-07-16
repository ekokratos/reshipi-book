import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'package:collection/collection.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({
    required RecipesRepository recipesRepository,
    required AuthRepository authRepository,
    required bool isNewRecipe,
    Recipe? recipe,
    required RecipeCategory category,
  })  : _recipesRepository = recipesRepository,
        super(
          RecipeState(
            isNewRecipe: isNewRecipe,
            recipe: recipe ??
                Recipe.empty(userId: authRepository.currentUser?.id ?? ''),
            ingredients: [...recipe?.ingredients ?? []],
            instructions: [...recipe?.instructions ?? []],
            category: category,
            recipeType: recipe?.type ?? RecipeType.veg,
          ),
        ) {
    on<RecipeIngredientSaved>(_onIngredientSaved);
    on<RecipeIngredientDeleted>(_onIngredientDeleted);
    on<RecipeInstructionSaved>(_onInstructionSaved);
    on<RecipeInstructionDeleted>(_onInstructionDeleted);
    on<RecipeSaved>(_onRecipeSaved);
    on<RecipeDeleted>(_onRecipeDeleted);
    on<RecipeImageAdded>(_onImageAdded);
    on<RecipeImageDeleted>(_onImageDeleted);
    on<RecipeImageEdited>(_onImageEdited);
    on<RecipeTypeChanged>(_onRecipeTypeChanged);
  }

  final RecipesRepository _recipesRepository;

  void _onRecipeTypeChanged(
    RecipeTypeChanged event,
    Emitter<RecipeState> emit,
  ) {
    emit(state.copyWith(recipeType: event.recipeType));
  }

  void _onIngredientSaved(
    RecipeIngredientSaved event,
    Emitter<RecipeState> emit,
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
    RecipeIngredientDeleted event,
    Emitter<RecipeState> emit,
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
    RecipeInstructionSaved event,
    Emitter<RecipeState> emit,
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
    RecipeInstructionDeleted event,
    Emitter<RecipeState> emit,
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
    RecipeSaved event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(status: RecipeStatus.loading));
    try {
      final savedRecipe = await _recipesRepository.saveRecipe(
        recipe: event.recipe.copyWith(
          ingredients: state.ingredients,
          instructions: state.instructions,
          category: state.category,
        ),
        imageFile: state.imageFile,
        recipeImageEdited: state.recipeImageEdited,
      );

      emit(
        state.copyWith(
          status: RecipeStatus.success,
          recipe: savedRecipe,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: RecipeStatus.failure));
    }
  }

  _onRecipeDeleted(
    RecipeDeleted event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(recipeDeleteStatus: RecipeDeleteStatus.loading));
    try {
      await _recipesRepository.deleteRecipe(recipe: event.recipe);

      emit(
        state.copyWith(
          recipeDeleteStatus: RecipeDeleteStatus.success,
          recipe: null,
        ),
      );
    } catch (_) {
      emit(state.copyWith(recipeDeleteStatus: RecipeDeleteStatus.failure));
    }
  }

  _onImageAdded(
    RecipeImageAdded event,
    Emitter<RecipeState> emit,
  ) {
    emit(state.copyWith(imageFile: event.imageFile));
  }

  _onImageDeleted(
    RecipeImageDeleted event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(imageDeleteStatus: RecipeImageDeleteStatus.loading));

    try {
      final recipe = state.recipe;
      if (recipe.imageUrl?.isNotEmpty ?? false) {
        await _recipesRepository.deleteImage(
          imageUrl: recipe.imageUrl!,
          recipeId: recipe.id,
        );
      }
      emit(
        state.copyWith(
          imageFile: null,
          recipe: recipe.copyWith(imageUrl: ''),
          imageDeleteStatus: RecipeImageDeleteStatus.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(imageDeleteStatus: RecipeImageDeleteStatus.failure));
    }
  }

  _onImageEdited(
    RecipeImageEdited event,
    Emitter<RecipeState> emit,
  ) async {
    emit(state.copyWith(imageFile: event.imageFile, recipeImageEdited: true));
  }
}

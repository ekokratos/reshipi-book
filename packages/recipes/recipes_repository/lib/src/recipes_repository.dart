import 'dart:io';

import 'package:recipes_api/recipes_api.dart';

class RecipesRepository {
  const RecipesRepository({
    required RecipesApi recipesApi,
  }) : _recipesApi = recipesApi;

  final RecipesApi _recipesApi;

  /// Provides a [Stream] of recipes.
  Stream<List<Recipe>> get recipes => _recipesApi.recipes;

  /// Fetches all recipes for a given [userId] and [category]
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  }) =>
      _recipesApi.getRecipies(userId: userId, category: category);

  /// Saves a [recipe].
  ///
  /// If a [recipe] with the same id already exists, it will be replaced.
  Future<Recipe> saveRecipe(
          {required Recipe recipe, required File? imageFile}) =>
      _recipesApi.saveRecipe(recipe: recipe, imageFile: imageFile);

  /// Deletes a [recipe] and its stored image.
  Future<void> deleteRecipe({required Recipe recipe}) =>
      _recipesApi.deleteRecipe(recipe: recipe);

  /// Uploads recipe image [file] for the current user with [userId].
  Future<void> uploadImage({
    required File file,
    required String userId,
    required String recipeId,
  }) =>
      _recipesApi.uploadImage(
        file: file,
        userId: userId,
        recipeId: recipeId,
      );

  /// Uploads recipe image [file] for the current user with [userId].
  Future<void> deleteImage(
          {required String imageUrl, required String recipeId}) =>
      _recipesApi.deleteImage(imageUrl: imageUrl, recipeId: recipeId);
}

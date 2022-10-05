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

  /// Filters the recipes with given [query]
  void onSearch({required String query, required}) =>
      _recipesApi.onSearch(query: query);

  /// Saves a [recipe].
  ///
  /// If a [recipe] with the same id already exists, it will be replaced.
  /// [recipeImageEdited] indicated if recipe image is edited/deleted,
  /// which marks the old image to be deleted from storage
  Future<Recipe> saveRecipe(
          {required Recipe recipe,
          required File? imageFile,
          bool recipeImageEdited = false}) =>
      _recipesApi.saveRecipe(
        recipe: recipe,
        imageFile: imageFile,
        recipeImageEdited: recipeImageEdited,
      );

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

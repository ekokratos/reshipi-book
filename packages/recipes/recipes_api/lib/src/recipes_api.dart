import 'dart:io';

import 'package:recipes_api/recipes_api.dart';

abstract class RecipesApi {
  const RecipesApi();

  Stream<List<Recipe>> get recipes;

  /// Fetches all recipes for a given [userId] and [category].
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  });

  /// Filters the recipes with given [query]
  void onSearch({required String query});

  /// Saves a [recipe].
  ///
  /// If a [recipe] with the same id already exists, it will be replaced.
  /// [recipeImageEdited] indicated if recipe image is edited/deleted,
  /// which marks the old image to be deleted from storage
  Future<Recipe> saveRecipe({
    required Recipe recipe,
    File? imageFile,
    bool recipeImageEdited = false,
  });

  /// Deletes a [recipe] and its stored image.
  Future<void> deleteRecipe({required Recipe recipe});

  /// Uploads recipe image [file] for the current user with [userId].
  Future<void> uploadImage({
    required File file,
    required String userId,
    required String recipeId,
  });

  /// Deletes the image at [imageUrl] path for [recipeId].
  Future<void> deleteImage(
      {required String imageUrl, required String recipeId});
}

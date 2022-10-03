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

  /// Saves a [recipe].
  ///
  /// If a [recipe] with the same id already exists, it will be replaced.
  Future<Recipe> saveRecipe({
    required Recipe recipe,
    required File? imageFile,
  });

  /// Deletes a [recipe] and its stored image.
  Future<void> deleteRecipe({required Recipe recipe});

  /// Uploads recipe image [file] for the current user with [userId].
  Future<void> uploadImage({
    required File file,
    required String userId,
    required String recipeId,
  });

  /// Deletes the image at [imageUrl] path.
  Future<void> deleteImage(
      {required String imageUrl, required String recipeId});
}

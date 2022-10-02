import 'package:recipes_api/recipes_api.dart';

abstract class RecipesApi {
  const RecipesApi();

  Stream<List<Recipe>> get recipes;

  /// Fetches all recipes for a given [userId] and [category]
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  });

  /// Saves a [recipe].
  ///
  /// If a [recipe] with the same id already exists, it will be replaced.
  Future<void> saveRecipe({required Recipe recipe});
}

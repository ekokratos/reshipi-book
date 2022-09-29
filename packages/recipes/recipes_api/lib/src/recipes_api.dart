import 'package:recipes_api/recipes_api.dart';

abstract class RecipesApi {
  const RecipesApi();

  Stream<List<Recipe>> get recipes;

  /// Fetches all recipes for a given [userId] and [category]
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  });
}

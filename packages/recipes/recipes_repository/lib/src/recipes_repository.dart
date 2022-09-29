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
}

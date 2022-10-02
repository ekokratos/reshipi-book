import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseRecipesApi extends RecipesApi {
  FirebaseRecipesApi() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final _recipeStreamController =
      BehaviorSubject<List<Recipe>>.seeded(const []);

  final kRecipesCollection = 'recipies';

  @override
  Stream<List<Recipe>> get recipes =>
      _recipeStreamController.asBroadcastStream();

  @override
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  }) async {
    List<Recipe> fetchedRecipes = [];

    try {
      await _db
          .collection(kRecipesCollection)
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: category.name)
          .get()
          .then((res) {
        for (var doc in res.docs) {
          final recipe = Recipe.fromJson(doc.data());
          fetchedRecipes.add(recipe);
        }
      });
      _recipeStreamController.add(fetchedRecipes);
      return fetchedRecipes;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveRecipe({required Recipe recipe}) async {
    try {
      ///Save recipe to Firestore
      log(recipe.toJson().toString());
      await _db
          .collection(kRecipesCollection)
          .doc(recipe.id)
          .set(recipe.toJson(), SetOptions(merge: true));

      ///Update recipe stream with new/edited recipe
      final recipes = [..._recipeStreamController.value];
      final recipeIndex = recipes.indexWhere((r) => r.id == recipe.id);
      if (recipeIndex >= 0) {
        recipes[recipeIndex] = recipe;
      } else {
        recipes.add(recipe);
      }
      _recipeStreamController.add(recipes);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipe({required Recipe recipe}) async {
    try {
      await _db.collection(kRecipesCollection).doc(recipe.id).delete();

      ///Remove the recipe from recipe stream
      final recipes = [..._recipeStreamController.value];
      final recipeIndex = recipes.indexWhere((r) => r.id == recipe.id);
      if (recipeIndex >= 0) {
        recipes.removeAt(recipeIndex);
      }
      _recipeStreamController.add(recipes);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

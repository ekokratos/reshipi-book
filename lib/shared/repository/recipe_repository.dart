import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_book/features/recipe_edit/models/enums.dart';
import 'package:recipe_book/features/recipe_edit/models/recipe.dart';
import 'package:rxdart/rxdart.dart';

class RecipeRepository {
  RecipeRepository() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  final _recipeStreamController =
      BehaviorSubject<List<Recipe>>.seeded(const []);

  Stream<List<Recipe>> get recipes =>
      _recipeStreamController.asBroadcastStream();

  /// Fetches all recipes for a given [userId]
  Future<List<Recipe>> getRecipies({
    required String userId,
    required RecipeCategory category,
  }) async {
    List<Recipe> fetchedRecipes = [];
    log(userId);
    log(category.name);

    try {
      await _db
          .collection('recipies')
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: category.name)
          .get()
          .then((res) {
        log(res.docs.toString());
        for (var doc in res.docs) {
          final recipe = Recipe.fromJson(doc.data());
          log(recipe.toString());
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
}

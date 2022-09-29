import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseRecipesApi extends RecipesApi {
  FirebaseRecipesApi() : _db = FirebaseFirestore.instance;

  final FirebaseFirestore _db;
  final _recipeStreamController =
      BehaviorSubject<List<Recipe>>.seeded(const []);

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
          .collection('recipies')
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
}

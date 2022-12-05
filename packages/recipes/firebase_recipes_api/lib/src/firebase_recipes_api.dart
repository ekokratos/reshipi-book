import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class FirebaseRecipesApi extends RecipesApi {
  FirebaseRecipesApi()
      : _db = FirebaseFirestore.instance,
        _storage = FirebaseStorage.instance;

  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  final _recipeStreamController =
      BehaviorSubject<List<Recipe>>.seeded(const []);

  List<Recipe> searchBackupRecipes = [];

  final kRecipesCollection = 'recipies';

  @override
  Stream<List<Recipe>> get recipes =>
      _recipeStreamController.asBroadcastStream();

  @override
  void onSearch({required String query}) {
    final recipes = [...searchBackupRecipes];
    if (query.isNotEmpty) {
      recipes.retainWhere(
          (recipe) => recipe.title.toLowerCase().contains(query.toLowerCase()));

      _recipeStreamController.add(recipes);
    } else {
      final r = [...searchBackupRecipes];
      _recipeStreamController.add(r);
    }
  }

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
      searchBackupRecipes = [...fetchedRecipes];
      return fetchedRecipes;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Recipe> saveRecipe({
    required Recipe recipe,
    File? imageFile,
    bool recipeImageEdited = false,
  }) async {
    try {
      ///Save recipe to Firestore
      ///
      await Future.wait([
        _db
            .collection(kRecipesCollection)
            .doc(recipe.id)
            .set(recipe.toJson(), SetOptions(merge: true)),
        if (recipeImageEdited &&
            recipe.imageUrl != null &&
            recipe.imageUrl!.isNotEmpty)
          deleteImage(imageUrl: recipe.imageUrl!, recipeId: recipe.id),
        if (imageFile != null)
          uploadImage(
                  file: imageFile, userId: recipe.userId, recipeId: recipe.id)
              .then((imageUrl) {
            recipe = recipe.copyWith(imageUrl: imageUrl);
          })
      ]);

      ///Update recipe stream with new/edited recipe
      final recipes = [..._recipeStreamController.value];
      final recipeIndex = recipes.indexWhere((r) => r.id == recipe.id);
      if (recipeIndex >= 0) {
        recipes[recipeIndex] = recipe;
      } else {
        recipes.add(recipe);
      }
      _recipeStreamController.add(recipes);
      searchBackupRecipes = [...recipes];

      return recipe;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipe({required Recipe recipe}) async {
    try {
      await Future.wait([
        if (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty)
          deleteImage(imageUrl: recipe.imageUrl!, recipeId: recipe.id),
        _db.collection(kRecipesCollection).doc(recipe.id).delete(),
      ]);

      ///Remove the recipe from recipe stream
      final recipes = [..._recipeStreamController.value];
      final recipeIndex = recipes.indexWhere((r) => r.id == recipe.id);
      if (recipeIndex >= 0) {
        recipes.removeAt(recipeIndex);
      }
      _recipeStreamController.add(recipes);
      searchBackupRecipes = [...recipes];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadImage({
    required File file,
    required String userId,
    required String recipeId,
  }) async {
    try {
      String downloadUrl = '';
      TaskSnapshot snapshot =
          await _storage.ref(userId).child(const Uuid().v4()).putFile(file);
      if (snapshot.state == TaskState.success) {
        downloadUrl = await snapshot.ref.getDownloadURL();
        await _db
            .collection(kRecipesCollection)
            .doc(recipeId)
            .update({'imageUrl': downloadUrl});
      }
      return downloadUrl;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteImage(
      {required String imageUrl, required String recipeId}) async {
    try {
      await Future.wait([
        _storage.refFromURL(imageUrl).delete(),
        _db
            .collection(kRecipesCollection)
            .doc(recipeId)
            .update({'imageUrl': ''}),
      ]);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

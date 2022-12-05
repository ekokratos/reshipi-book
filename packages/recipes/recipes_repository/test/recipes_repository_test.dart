import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

class MockRecipesApi extends Mock implements RecipesApi {}

class FakeRecipe extends Fake implements Recipe {}

class FakeFile extends Fake implements File {}

void main() {
  group('RecipesRepository', () {
    late RecipesRepository sut;
    late RecipesApi api;

    const userId = '1';
    const category = RecipeCategory.other;

    final recipes = [
      Recipe.empty(userId: '1'),
      Recipe.empty(userId: '1'),
      Recipe.empty(userId: '2'),
    ];

    RecipesRepository createSubject() => RecipesRepository(recipesApi: api);

    setUpAll(() {
      registerFallbackValue(FakeRecipe());
      registerFallbackValue(FakeFile());
    });

    setUp(
      () {
        api = MockRecipesApi();
        sut = createSubject();
      },
    );

    test('Constructor works properly', () {
      expect(createSubject, returnsNormally);
    });

    group('recipes getter', () {
      setUp(() {
        when(() => api.recipes).thenAnswer((_) => Stream.value(recipes));
      });
      test('makes correct api request', () {
        expect(
          sut.recipes,
          isNot(throwsA(anything)),
        );

        verify(() => api.recipes).called(1);
      });

      test('returns stream of current list recipes', () {
        expect(
          sut.recipes,
          emits(recipes),
        );
      });
    });

    group('getRecipies', () {
      final futureRecipes = Future.value(recipes);
      setUp(() {
        when(() => api.getRecipies(userId: userId, category: category))
            .thenAnswer((_) => futureRecipes);
      });
      test('makes correct api request', () async {
        expect(
          await sut.getRecipies(userId: userId, category: category),
          isNot(throwsA(anything)),
        );

        verify(() => api.getRecipies(userId: userId, category: category))
            .called(1);
      });

      test('returns future of current list recipes', () {
        expect(
          sut.getRecipies(userId: userId, category: category),
          futureRecipes,
        );
      });
    });

    group('onSearch', () {
      test('makes correct api request', () {
        when(() => api.onSearch(query: any(named: 'query'))).thenAnswer((_) {});

        sut.onSearch(query: 'query');
        verify(() => api.onSearch(query: 'query')).called(1);
      });
    });

    group('saveRecipe', () {
      test('makes correct api request', () {
        when(() => api.saveRecipe(recipe: any(named: 'recipe')))
            .thenAnswer((_) => Future.value(FakeRecipe()));

        final newRecipe = Recipe.empty(userId: '1');
        expect(sut.saveRecipe(recipe: newRecipe), completes);
        verify(() => api.saveRecipe(recipe: newRecipe)).called(1);
      });
    });

    group('deleteRecipe', () {
      test('makes correct api request', () {
        when(() => api.deleteRecipe(recipe: any(named: 'recipe')))
            .thenAnswer((_) async {});

        expect(sut.deleteRecipe(recipe: recipes[0]), completes);
        verify(() => api.deleteRecipe(recipe: recipes[0])).called(1);
      });
    });

    group('uploadImage', () {
      test('makes correct api request', () {
        when(() => api.uploadImage(
            file: any(named: 'file'),
            userId: any(named: 'userId'),
            recipeId: any(named: 'recipeId'))).thenAnswer((_) async {});

        final image = File('/imagePath');

        expect(
            sut.uploadImage(
                file: image, userId: userId, recipeId: recipes[0].id),
            completes);
        verify(() => api.uploadImage(
            file: image, userId: userId, recipeId: recipes[0].id)).called(1);
      });
    });

    group('deleteImage', () {
      test('makes correct api request', () {
        when(() => api.deleteImage(
            imageUrl: any(named: 'imageUrl'),
            recipeId: any(named: 'recipeId'))).thenAnswer((_) async {});

        expect(sut.deleteImage(imageUrl: 'imageUrl', recipeId: recipes[0].id),
            completes);
        verify(() =>
                api.deleteImage(imageUrl: 'imageUrl', recipeId: recipes[0].id))
            .called(1);
      });
    });
  });
}

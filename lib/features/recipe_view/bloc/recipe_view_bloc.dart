import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_book/features/recipe_edit/models/enums.dart';
import 'package:recipe_book/features/recipe_edit/models/recipe.dart';
import 'package:recipe_book/shared/repository/auth_reppository.dart';
import 'package:recipe_book/shared/repository/recipe_repository.dart';

part 'recipe_view_event.dart';
part 'recipe_view_state.dart';

class RecipeViewBloc extends Bloc<RecipeViewEvent, RecipeViewState> {
  RecipeViewBloc({
    required RecipeRepository recipeRepository,
    required AuthRepository authRepository,
  })  : _recipeRepository = recipeRepository,
        _authRepository = authRepository,
        super(const RecipeViewState()) {
    on<RecipeViewRecipesRequested>(_onRecipesRequested);
    // on<RecipeViewSubscriptionRequested>(_onSubscriptionRequested);
  }

  void _onRecipesRequested(
    RecipeViewRecipesRequested event,
    Emitter<RecipeViewState> emit,
  ) async {
    emit(state.copyWith(status: RecipeViewStatus.loading));

    try {
      await _recipeRepository.getRecipies(
        userId: _authRepository.currentUser!.uid,
        category: event.category,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeViewStatus.failure,
        ),
      );
    }

    await emit.forEach<List<Recipe>>(
      _recipeRepository.recipes,
      onData: (recipes) => state.copyWith(
        status: RecipeViewStatus.success,
        recipes: recipes,
      ),
      onError: (_, __) => state.copyWith(
        status: RecipeViewStatus.failure,
      ),
    );
  }

  final RecipeRepository _recipeRepository;
  final AuthRepository _authRepository;
}

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe_listing_event.dart';
part 'recipe_listing_state.dart';

class RecipeListingBloc extends Bloc<RecipeListingEvent, RecipeListingState> {
  RecipeListingBloc({
    required RecipesRepository recipesRepository,
    required AuthRepository authRepository,
  })  : _recipesRepository = recipesRepository,
        _authRepository = authRepository,
        super(const RecipeListingState()) {
    on<RecipeListingRecipesRequested>(_onRecipesRequested);
    on<RecipeListingSearch>(_onSearch);
    on<RecipeListingSearchClear>(_onSearchClear);
  }

  void _onRecipesRequested(
    RecipeListingRecipesRequested event,
    Emitter<RecipeListingState> emit,
  ) async {
    emit(state.copyWith(status: RecipeListingStatus.loading));

    try {
      await _recipesRepository.getRecipies(
        userId: _authRepository.currentUser!.id,
        category: event.category,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecipeListingStatus.failure,
        ),
      );
    }

    await emit.forEach<List<Recipe>>(
      _recipesRepository.recipes,
      onData: (recipes) => state.copyWith(
        status: RecipeListingStatus.success,
        recipes: recipes,
      ),
      onError: (_, __) => state.copyWith(
        status: RecipeListingStatus.failure,
      ),
    );
  }

  void _onSearch(
    RecipeListingSearch event,
    Emitter<RecipeListingState> emit,
  ) {
    _recipesRepository.onSearch(
      query: event.query,
    );
  }

  void _onSearchClear(
    RecipeListingSearchClear event,
    Emitter<RecipeListingState> emit,
  ) async {
    _recipesRepository.onSearch(
      query: '',
    );
  }

  final RecipesRepository _recipesRepository;
  final AuthRepository _authRepository;
}

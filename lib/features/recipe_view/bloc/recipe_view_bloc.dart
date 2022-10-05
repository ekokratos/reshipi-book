import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe_view_event.dart';
part 'recipe_view_state.dart';

class RecipeViewBloc extends Bloc<RecipeViewEvent, RecipeViewState> {
  RecipeViewBloc({
    required RecipesRepository recipesRepository,
    required AuthRepository authRepository,
  })  : _recipesRepository = recipesRepository,
        _authRepository = authRepository,
        super(const RecipeViewState()) {
    on<RecipeViewRecipesRequested>(_onRecipesRequested);
    on<RecipeViewSearch>(_onSearch);
    on<RecipeViewSearchClear>(_onSearchClear);
  }

  void _onRecipesRequested(
    RecipeViewRecipesRequested event,
    Emitter<RecipeViewState> emit,
  ) async {
    emit(state.copyWith(status: RecipeViewStatus.loading));

    try {
      await _recipesRepository.getRecipies(
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
      _recipesRepository.recipes,
      onData: (recipes) => state.copyWith(
        status: RecipeViewStatus.success,
        recipes: recipes,
      ),
      onError: (_, __) => state.copyWith(
        status: RecipeViewStatus.failure,
      ),
    );
  }

  void _onSearch(
    RecipeViewSearch event,
    Emitter<RecipeViewState> emit,
  ) {
    _recipesRepository.onSearch(
      query: event.query,
    );
  }

  void _onSearchClear(
    RecipeViewSearchClear event,
    Emitter<RecipeViewState> emit,
  ) async {
    _recipesRepository.onSearch(
      query: '',
    );
  }

  final RecipesRepository _recipesRepository;
  final AuthRepository _authRepository;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe_edit_event.dart';
part 'recipe_edit_state.dart';

class RecipeEditBloc extends Bloc<RecipeEditEvent, RecipeEditState> {
  RecipeEditBloc({
    required RecipesRepository recipesRepository,
    Recipe? recipe,
  })  : _recipesRepository = recipesRepository,
        super(
          RecipeEditState(recipe: recipe),
        ) {
    on<RecipeEditEvent>((event, emit) {});
  }

  final RecipesRepository _recipesRepository;
}

part of 'recipe_view_bloc.dart';

enum RecipeViewStatus { initial, loading, success, failure }

class RecipeViewState extends Equatable {
  const RecipeViewState({
    this.status = RecipeViewStatus.initial,
    this.recipes = const [],
  });

  final RecipeViewStatus status;
  final List<Recipe> recipes;

  RecipeViewState copyWith({
    RecipeViewStatus? status,
    List<Recipe>? recipes,
  }) {
    return RecipeViewState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object> get props => [status, recipes];
}

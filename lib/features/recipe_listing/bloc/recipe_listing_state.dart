part of 'recipe_listing_bloc.dart';

enum RecipeListingStatus { initial, loading, success, failure }

class RecipeListingState extends Equatable {
  const RecipeListingState({
    this.status = RecipeListingStatus.initial,
    this.recipes = const [],
  });

  final RecipeListingStatus status;
  final List<Recipe> recipes;

  RecipeListingState copyWith({
    RecipeListingStatus? status,
    List<Recipe>? recipes,
  }) {
    return RecipeListingState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object> get props => [status, recipes];
}

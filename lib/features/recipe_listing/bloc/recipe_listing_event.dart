part of 'recipe_listing_bloc.dart';

abstract class RecipeListingEvent extends Equatable {
  const RecipeListingEvent();

  @override
  List<Object> get props => [];
}

class RecipeListingRecipesRequested extends RecipeListingEvent {
  const RecipeListingRecipesRequested({
    required this.category,
  });

  final RecipeCategory category;
}

class RecipeListingSearch extends RecipeListingEvent {
  const RecipeListingSearch({required this.query});
  final String query;
}

class RecipeListingSearchClear extends RecipeListingEvent {
  const RecipeListingSearchClear();
}

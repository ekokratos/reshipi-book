part of 'recipe_view_bloc.dart';

abstract class RecipeViewEvent extends Equatable {
  const RecipeViewEvent();

  @override
  List<Object> get props => [];
}

class RecipeViewRecipesRequested extends RecipeViewEvent {
  const RecipeViewRecipesRequested({
    required this.category,
  });

  final RecipeCategory category;
}

part of 'recipe_edit_bloc.dart';

enum RecipeEditStatus { initial, loading, success, failure }

class RecipeEditState extends Equatable {
  const RecipeEditState({
    this.status = RecipeEditStatus.initial,
    this.recipe,
  });

  final RecipeEditStatus status;
  final Recipe? recipe;

  bool get isNewRecipe => recipe == null;

  RecipeEditState copyWith({
    RecipeEditStatus? status,
    Recipe? recipe,
  }) {
    return RecipeEditState(
      status: status ?? this.status,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  List<Object?> get props => [status, recipe];
}

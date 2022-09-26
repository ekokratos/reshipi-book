part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
  
  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

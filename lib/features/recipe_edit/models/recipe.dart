import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_book/features/recipe_edit/models/enums.dart';
import 'package:uuid/uuid.dart';

part 'recipe.g.dart';

@immutable
@JsonSerializable()
class Recipe extends Equatable {
  Recipe({
    String? id,
    required this.userId,
    required this.title,
    this.description = '',
    this.imageUrl = '',
    required this.cookingTime,
    required this.type,
    required this.category,
    this.ingredients,
    this.instructions,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? imageUrl;
  final String cookingTime;
  final RecipeType type;
  final RecipeCategory category;
  final List<Ingredient>? ingredients;
  final List<Instruction>? instructions;

  Recipe copyWith({
    String? title,
    String? description,
    String? imageUrl,
    String? cookingTime,
    RecipeType? type,
    RecipeCategory? category,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
  }) {
    return Recipe(
      id: id,
      userId: userId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      cookingTime: cookingTime ?? this.cookingTime,
      type: type ?? this.type,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  /// Deserializes the given json into a [Recipe].
  static Recipe fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  /// Converts this [Recipe] into a json.
  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        imageUrl,
        cookingTime,
        type,
        category,
        ingredients,
        instructions
      ];

  @override
  get stringify => true;
}

@immutable
@JsonSerializable()
class Ingredient extends Equatable {
  Ingredient({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String name;

  Ingredient copyWith({String? name}) {
    return Ingredient(
      id: id,
      name: name ?? this.name,
    );
  }

  /// Deserializes the given json into a [Ingredient].
  static Ingredient fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  /// Converts this [Ingredient] into a json.
  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  List<Object?> get props => [id, name];

  @override
  get stringify => true;
}

@immutable
@JsonSerializable()
class Instruction extends Equatable {
  Instruction({
    String? id,
    required this.name,
    required this.stepNumber,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final int stepNumber;

  Instruction copyWith({String? name, int? stepNumber}) {
    return Instruction(
      id: id,
      name: name ?? this.name,
      stepNumber: stepNumber ?? this.stepNumber,
    );
  }

  /// Deserializes the given json into a [Instruction].
  static Instruction fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  /// Converts this [Instruction] into a json.
  Map<String, dynamic> toJson() => _$InstructionToJson(this);

  @override
  List<Object?> get props => [id, name, stepNumber];

  @override
  get stringify => true;
}

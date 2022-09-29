// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      cookingTime: json['cookingTime'] as String,
      type: $enumDecode(_$RecipeTypeEnumMap, json['type']),
      category: $enumDecode(_$RecipeCategoryEnumMap, json['category']),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'cookingTime': instance.cookingTime,
      'type': _$RecipeTypeEnumMap[instance.type]!,
      'category': _$RecipeCategoryEnumMap[instance.category]!,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
    };

const _$RecipeTypeEnumMap = {
  RecipeType.veg: 'veg',
  RecipeType.nonveg: 'nonveg',
};

const _$RecipeCategoryEnumMap = {
  RecipeCategory.breakfast: 'breakfast',
  RecipeCategory.meal: 'meal',
  RecipeCategory.snack: 'snack',
  RecipeCategory.dessert: 'dessert',
  RecipeCategory.beverage: 'beverage',
  RecipeCategory.other: 'other',
};

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
      id: json['id'] as String?,
      name: json['name'] as String,
      stepNumber: json['stepNumber'] as int,
    );

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stepNumber': instance.stepNumber,
    };

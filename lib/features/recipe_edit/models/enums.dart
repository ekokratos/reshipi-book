enum RecipeCategory {
  breakfast('Breakfast'),
  meal('Lunch/Dinner'),
  snack('Snacks'),
  dessert('Dessert'),
  beverage('Beverage'),
  other('Other');

  const RecipeCategory(this.value);
  final String value;
}

enum RecipeType {
  veg('Veg'),
  nonveg('Non-veg');

  const RecipeType(this.value);
  final String value;
}

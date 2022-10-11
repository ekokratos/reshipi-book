import 'package:recipe_book/l10n/localization.dart';

class LocalizationEN implements Localization {
  @override
  String get loading => 'Loading...';

  @override
  String get oops => 'Oops! Something went wrong 😞';

  @override
  String get retry => 'retry';

  @override
  String get name => 'Name';

  @override
  String get mail => 'EMail';

  @override
  String get instruction => 'Instruction';

  @override
  String get no_description => 'No description';

  @override
  String get no_recipes => 'No recipes found';

  @override
  String get error_occurred_save_recipe =>
      'An error occurred while saving the recipe. Please try again.';

  @override
  String get error_occurred_load_recipe =>
      'An error occurred while loading recipes. Please try refreshing.';

  @override
  String get error_occurred_delete_recipe =>
      'An error occurred while deleting the recipe.';

  @override
  String get error_occurred_delete_image =>
      'Please try again.An error occurred while deleting the image.';

  @override
  String get recipe_title => 'Title';

  @override
  String get recipe_name => 'Recipe name';

  @override
  String get recipe_description => 'Description';

  @override
  String get recipe_description_text => 'Type something about the recipe';

  @override
  String get recipe_deleted => 'Recipe deleted';

  @override
  String get recipe_deleting => 'Deleting Recipe';

  @override
  String get recipe_type => 'Recipe Type';

  @override
  String get ingredient => 'Ingredient';

  @override
  String get ingredients => 'Ingredients:';

  @override
  String get what_to_do => 'What would you like\nto ';

  @override
  String get prepare => 'prepare?';

  @override
  String get cooking_time => 'Cooking time (hh:mm)';

  @override
  String get cancel => 'Cancel';

  @override
  String get requ => 'Required';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get save_recipe => 'Saving Recipe';

  @override
  String get pw => 'Password';

  @override
  String get pw_text =>
      'Your password must be 8 or more characters long and contain a mix of upper and lower case letters, numbers and symbols.';

  @override
  String get pw_enter => 'Enter password';

  @override
  String get pw_reset_title => 'Reset Password';

  @override
  String get pw_reset_message => 'Reset Password';

  @override
  String get pw_forgot_title => 'Forgot Password?';

  @override
  String get pw_forgot_message =>
      'Please enter your email to recover your password:';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Log out';

  @override
  String get logout_message => 'Are you sure you want to log out?';

  @override
  String get new_account => 'Don\'t have an account? ';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get category => 'Category';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch_dinner => 'Lunch/Dinner';

  @override
  String get meal => 'Meal';

  @override
  String get snack => 'Snack';

  @override
  String get dessert => 'Dessert';

  @override
  String get beverage => 'Beverage';

  @override
  String get others => 'Ohters';
}

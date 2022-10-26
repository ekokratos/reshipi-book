import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get forgotPasswordBtn => 'Forgot password?';

  @override
  String get login => 'Login';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign Up';

  @override
  String get forgotPasswordAppBarTitle => 'Forgot password';

  @override
  String get passwordRecovery => 'Please enter your email to recover your password:';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get passwordStrength => 'Your password must be 8 or more characters long and contain a mix of upper and lower case letters, numbers and symbols.';

  @override
  String categoryAppBarTitle(Object userName) {
    return 'Hi, $userName';
  }

  @override
  String get logOut => 'Log out';

  @override
  String get cancel => 'Cancel';

  @override
  String get logOutConfirmation => 'Are you sure you want to log out?';

  @override
  String get recipeListSearch => 'Search';

  @override
  String get recipeListNoRecipe => 'No recipes found';

  @override
  String get recipeEditTitleField => 'Title';

  @override
  String get recipeEditTitleHint => 'Recipe name';

  @override
  String get recipeEditDescField => 'Description';

  @override
  String get recipeEditDescHint => 'Type something about the recipe';

  @override
  String get recipeEditCategoryField => 'Category';

  @override
  String get recipeEditRecipeTypeField => 'Recipe type';

  @override
  String get recipeEditTimeField => 'Cooking time (hh:mm)';

  @override
  String get recipeEditIngredientsTitle => 'Ingredients:';

  @override
  String get recipeEditInsctructionsTitle => 'Cooking Instructions:';

  @override
  String get recipeEditIngredient => 'Ingredient';

  @override
  String get recipeEditInsctruction => 'Instruction';

  @override
  String get recipeEditSaveBtn => 'Save';

  @override
  String get recipeEditImageDialogText => 'Pick image from:';

  @override
  String get recipeEditImageDialogGallery => 'Gallery';

  @override
  String get recipeEditImageDialogCamera => 'Camera';

  @override
  String recipeEditRemoveItemDialogTitle(Object item) {
    return 'Remove $item';
  }

  @override
  String recipeEditRemoveItemDialogDesc(Object item) {
    return 'Are you sure you want to remove the $item?';
  }

  @override
  String get recipeEditRemoveItemDialogBtn => 'Remove';

  @override
  String get recipeEditSavingDialog => 'Saving Recipe';

  @override
  String get recipeEditSavingError => 'An error occurred while saving the recipe. Please try again.';

  @override
  String get recipeListError => 'An error occurred while loading recipes. Please try refreshing.';

  @override
  String get recipeListFailure => 'Oops! Something went wrong 😞';

  @override
  String get recipeReadDeleteDialog => 'Deleting Recipe';

  @override
  String get recipeEditDeleteError => 'An error occurred while deleting the recipe. Please try again.';

  @override
  String get recipeReadDeleteSuccess => 'Recipe deleted';
}

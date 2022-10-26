import 'app_localizations.dart';

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get email => 'ಇಮೇಲ್';

  @override
  String get password => 'ಗುಪ್ತಪದ';

  @override
  String get name => 'ಹೆಸರು';

  @override
  String get forgotPasswordBtn => 'ಪಾಸ್ವರ್ಡ್ ಮರೆತಿರಾ?';

  @override
  String get login => 'ಲಾಗಿನ್';

  @override
  String get noAccount => 'ಖಾತೆ ಇಲ್ಲವೇ? ';

  @override
  String get signUp => 'ಸೈನ್ ಅಪ್';

  @override
  String get forgotPasswordAppBarTitle => 'ಪಾಸ್ವರ್ಡ್ ಮರೆತಿರಾ';

  @override
  String get passwordRecovery => 'ನಿಮ್ಮ ಪಾಸ್‌ವರ್ಡ್ ಅನ್ನು ಮರುಪಡೆಯಲು ನಿಮ್ಮ ಇಮೇಲ್ ಅನ್ನು ನಮೂದಿಸಿ:';

  @override
  String get resetPassword => 'ಪಾಸ್ವರ್ಡ್ ಮರುಹೊಂದಿಸಿ';

  @override
  String get passwordStrength => 'ನಿಮ್ಮ ಪಾಸ್‌ವರ್ಡ್ 8 ಅಥವಾ ಅದಕ್ಕಿಂತ ಹೆಚ್ಚು ಅಕ್ಷರಗಳನ್ನು ಹೊಂದಿರಬೇಕು ಮತ್ತು ದೊಡ್ಡ ಮತ್ತು ಸಣ್ಣ ಅಕ್ಷರಗಳು, ಸಂಖ್ಯೆಗಳು ಮತ್ತು ಚಿಹ್ನೆಗಳ ಮಿಶ್ರಣವನ್ನು ಹೊಂದಿರಬೇಕು.';

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

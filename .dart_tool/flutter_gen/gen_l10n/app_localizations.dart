import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kn.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kn')
  ];

  /// Label for Email textfield
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for Password textfield
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Label for Name textfield
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordBtn;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No account text in Login Screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Title text shown in the AppBar of Forgot password screen
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordAppBarTitle;

  /// Text shown to enter email in Forgot Password screen
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to recover your password:'**
  String get passwordRecovery;

  /// Text shown on button to reset password in Forgot Password screen
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Hint text for creating strong password in Sing Up screen
  ///
  /// In en, this message translates to:
  /// **'Your password must be 8 or more characters long and contain a mix of upper and lower case letters, numbers and symbols.'**
  String get passwordStrength;

  /// Title text shown in the AppBar of Category Screen
  ///
  /// In en, this message translates to:
  /// **'Hi, {userName}'**
  String categoryAppBarTitle(Object userName);

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Log out dialog confirmation text
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutConfirmation;

  /// Label for Search textfield in Recipe List Screen
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get recipeListSearch;

  /// Text shown when no recipes are found in Recipe List Screen
  ///
  /// In en, this message translates to:
  /// **'No recipes found'**
  String get recipeListNoRecipe;

  /// Label for Title textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get recipeEditTitleField;

  /// Hint text for Title textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Recipe name'**
  String get recipeEditTitleHint;

  /// Label for Description textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get recipeEditDescField;

  /// Hint text for Description textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Type something about the recipe'**
  String get recipeEditDescHint;

  /// Label for Category textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get recipeEditCategoryField;

  /// Label for Recipe Type textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Recipe type'**
  String get recipeEditRecipeTypeField;

  /// Label for Cooking time textfield in Recipe Edit Screen
  ///
  /// In en, this message translates to:
  /// **'Cooking time (hh:mm)'**
  String get recipeEditTimeField;

  /// No description provided for @recipeEditIngredientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ingredients:'**
  String get recipeEditIngredientsTitle;

  /// No description provided for @recipeEditInsctructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cooking Instructions:'**
  String get recipeEditInsctructionsTitle;

  /// No description provided for @recipeEditIngredient.
  ///
  /// In en, this message translates to:
  /// **'Ingredient'**
  String get recipeEditIngredient;

  /// No description provided for @recipeEditInsctruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get recipeEditInsctruction;

  /// Floating button text in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get recipeEditSaveBtn;

  /// Image picker dialog title in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Pick image from:'**
  String get recipeEditImageDialogText;

  /// Image picker dialog Gallery button in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get recipeEditImageDialogGallery;

  /// Image picker dialog Camera button in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get recipeEditImageDialogCamera;

  /// Remove Ingredient/Instruction dialog title in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Remove {item}'**
  String recipeEditRemoveItemDialogTitle(Object item);

  /// Remove Ingredient/Instruction dialog description in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove the {item}?'**
  String recipeEditRemoveItemDialogDesc(Object item);

  /// No description provided for @recipeEditRemoveItemDialogBtn.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get recipeEditRemoveItemDialogBtn;

  /// Loading dialog text on saving recipe in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'Saving Recipe'**
  String get recipeEditSavingDialog;

  /// Text in Snackbar showing error while saving in Edit Recipe Screen
  ///
  /// In en, this message translates to:
  /// **'An error occurred while saving the recipe. Please try again.'**
  String get recipeEditSavingError;

  /// Text in Snackbar showing error while loading recipes in Recipe List Screen
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading recipes. Please try refreshing.'**
  String get recipeListError;

  /// Text displayed on error in Recipe List Screen
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong 😞'**
  String get recipeListFailure;

  /// Loading dialog text on deleting recipe in Recipe Read Screen
  ///
  /// In en, this message translates to:
  /// **'Deleting Recipe'**
  String get recipeReadDeleteDialog;

  /// Text in Snackbar showing error while deleting recipe in Recipe Read Screen
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting the recipe. Please try again.'**
  String get recipeEditDeleteError;

  /// Successful snackbar text on deleting recipe in Recipe Read Screen
  ///
  /// In en, this message translates to:
  /// **'Recipe deleted'**
  String get recipeReadDeleteSuccess;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'kn': return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

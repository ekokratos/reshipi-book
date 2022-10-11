import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:recipe_book/l10n/localization_de.dart';
import 'package:recipe_book/l10n/localization_en.dart';

abstract class Localization {
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get loading;
  String get oops;
  String get retry;
  String get name;
  String get mail;
  String get instruction;
  String get no_description;
  String get no_recipes;
  String get error_occurred_save_recipe;
  String get error_occurred_load_recipe;
  String get error_occurred_delete_recipe;
  String get error_occurred_delete_image;
  String get recipe_title;
  String get recipe_name;
  String get recipe_description;
  String get recipe_description_text;
  String get recipe_deleted;
  String get recipe_deleting;
  String get recipe_type;
  String get cooking_time;
  String get ingredient;
  String get ingredients;
  String get what_to_do;
  String get prepare;
  String get save;
  String get add;
  String get cancel;
  String get requ;
  String get save_recipe;
  String get pw;
  String get pw_text;
  String get pw_enter;
  String get pw_reset_title;
  String get pw_reset_message;
  String get pw_forgot_title;
  String get pw_forgot_message;
  String get login;
  String get logout;
  String get logout_message;
  String get new_account;
  String get sign_up;
  String get category;
  String get breakfast;
  String get lunch_dinner;
  String get meal;
  String get snack;
  String get dessert;
  String get beverage;
  String get others;
}

class ReshipiLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const ReshipiLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == 'en') {
      return LocalizationEN();
    }
    return LocalizationDE();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}

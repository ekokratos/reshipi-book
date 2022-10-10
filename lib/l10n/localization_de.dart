import 'package:recipe_book/l10n/localization.dart';

class LocalizationDE implements Localization {
  @override
  String get loading => 'Lädt...';

  @override
  String get oops => 'Oopsie, da lief etwas schief 😞';

  @override
  String get retry => 'Wiederholen';

  @override
  String get name => 'Name';

  @override
  String get mail => 'E-Mail';

  @override
  String get instruction => 'Anleitung';

  @override
  String get no_description => 'Keine Anleitung';

  @override
  String get no_recipes => 'Keine Rezepte gefunden';

  @override
  String get error_occurred_save_recipe =>
      'Während des Speichers ist ein Fehler aufgetreteten. Bitte erneut probieren.';

  @override
  String get error_occurred_load_recipe =>
      'Während des Ladens ist ein Fehler aufgetreteten. Bitte erneut probieren.';

  @override
  String get error_occurred_delete_recipe =>
      'Während des Löschens ist ein Fehler aufgetreteten. Bitte erneut probieren.';

  @override
  String get error_occurred_delete_image =>
      'Während des Löschens ist ein Fehler aufgetreteten. Bitte erneut probieren.';

  @override
  String get recipe_title => 'Titel';

  @override
  String get recipe_name => 'Rezept-Name';

  @override
  String get recipe_description => 'Beschreibung';

  @override
  String get recipe_description_text => 'Schreib etwas über das Rezept';

  @override
  String get recipe_deleted => 'Rezept löschen';

  @override
  String get recipe_deleting => 'Rezept gelöscht';

  @override
  String get recipe_type => 'Art des Rezepts';

  @override
  String get ingredient => 'Zutat';

  @override
  String get ingredients => 'Zutaten:';

  @override
  String get what_to_do => 'Was möchtest du machen?';

  @override
  String get prepare => 'Vorbereiten?';

  @override
  String get cooking_time => 'Kochzeit (hh:mm)';

  @override
  String get cancel => 'Abbruch';

  @override
  String get requ => 'Erforderlich';

  @override
  String get save => 'Speichern';

  @override
  String get add => 'Hinzufügen';

  @override
  String get save_recipe => 'Rezept speichern';

  @override
  String get pw => 'Passwort';

  @override
  String get pw_text =>
      'Das Passwort muss mindestens 8 Zeichen lang sein und aus großen und kleinen Buchstabden, sowie Zeichen und Symbolen bestehen.';

  @override
  String get pw_enter => 'Passwort eingeben';

  @override
  String get pw_reset_title => 'Passwort zurücksetzen';

  @override
  String get pw_reset_message => 'Passwort zurücksetzen';

  @override
  String get pw_forgot_title => 'Passwort vergessen?';

  @override
  String get pw_forgot_message =>
      'Bitte gib deine E-Mail zum zurücksetzen ein:';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Log Out';

  @override
  String get logout_message => 'Bist du sicher?';

  @override
  String get new_account => 'Noch ein Account?';

  @override
  String get sign_up => 'Anmelden';

  @override
  String get category => 'Kategorie';

  @override
  String get breakfast => 'Frühstück';

  @override
  String get lunch_dinner => 'Mittagessen';

  @override
  String get meal => 'Mahlzeit';

  @override
  String get snack => 'Snack';

  @override
  String get dessert => 'Dessert';

  @override
  String get beverage => 'Erfrischungen';

  @override
  String get others => 'Weiteres';
}

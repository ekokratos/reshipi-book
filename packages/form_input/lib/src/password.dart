import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

final class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (!_passwordRegex.hasMatch(value)) return PasswordValidationError.invalid;
    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Enter password';
      case PasswordValidationError.invalid:
        return 'Invalid password';
    }
  }
}

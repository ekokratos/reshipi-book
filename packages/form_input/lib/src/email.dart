import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

final class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([super.value = '']) : super.pure();
  const Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!_emailRegex.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}

extension EmailValidationErrorX on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.empty:
        return 'Enter email';
      case EmailValidationError.invalid:
        return 'Invalid email';
    }
  }
}

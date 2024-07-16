import 'package:formz/formz.dart';

enum NameValidationError { empty, invalid }

final class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([super.value = '']) : super.pure();
  const Name.dirty([super.value = '']) : super.dirty();

  static final _nameRegex = RegExp(
    r'^[a-zA-Z]+([\ A-Za-z]+)*$',
  );

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    if (!_nameRegex.hasMatch(value)) return NameValidationError.invalid;
    return null;
  }
}

extension NameValidationErrorX on NameValidationError {
  String text() {
    switch (this) {
      case NameValidationError.empty:
        return 'Enter name';
      case NameValidationError.invalid:
        return 'Invalid name';
    }
  }
}

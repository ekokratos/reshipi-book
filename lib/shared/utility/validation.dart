class Validation {
  static String? validateEmail({String? value, bool required = true}) {
    if (!required && (value != null && value.isEmpty)) {
      return null;
    }
    Pattern pattern = r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value ?? '')) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value ?? '')) {
      return 'Invalid password';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    Pattern pattern = r'^[a-zA-Z]+([\ A-Za-z]+)*$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value ?? '')) {
      return 'Enter Valid Name';
    } else {
      return null;
    }
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }
}

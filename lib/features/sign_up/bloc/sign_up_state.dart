part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isPasswordVisible = false,
    this.passwordStrengthLevel = 0,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.authException,
  });

  final Name name;
  final Email email;
  final Password password;
  final bool isPasswordVisible;
  final int passwordStrengthLevel;
  final FormzSubmissionStatus status;
  final AuthException? authException;
  final bool isValid;

  @override
  List<Object> get props => [
        name,
        email,
        password,
        isPasswordVisible,
        passwordStrengthLevel,
        status,
        isValid,
      ];

  SignUpState copyWith({
    Name? name,
    Email? email,
    Password? password,
    bool? isPasswordVisible,
    bool? isValid,
    int? passwordStrengthLevel,
    FormzSubmissionStatus? status,
    AuthException? authException,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isValid: isValid ?? this.isValid,
      passwordStrengthLevel:
          passwordStrengthLevel ?? this.passwordStrengthLevel,
      status: status ?? this.status,
      authException: authException,
    );
  }
}

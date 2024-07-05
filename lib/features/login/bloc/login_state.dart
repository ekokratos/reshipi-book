part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final bool isPasswordVisible;

  final AuthException? authException;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isPasswordVisible = false,
    this.authException,
  });

  @override
  List<Object> get props =>
      [status, email, password, isValid, isPasswordVisible];

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    bool? isPasswordVisible,
    AuthException? authException,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      authException: authException,
    );
  }
}

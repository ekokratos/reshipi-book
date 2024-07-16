part of 'password_reset_bloc.dart';

class PasswordResetState extends Equatable {
  const PasswordResetState({
    required this.email,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.authException,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final bool isValid;
  final AuthException? authException;

  @override
  List<Object> get props => [status, email, isValid];

  PasswordResetState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    bool? isValid,
    AuthException? authException,
  }) {
    return PasswordResetState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      authException: authException,
    );
  }
}

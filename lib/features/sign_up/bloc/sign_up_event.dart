part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpNameChanged extends SignUpEvent {
  const SignUpNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class SignUpPasswordToggled extends SignUpEvent {
  const SignUpPasswordToggled();
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

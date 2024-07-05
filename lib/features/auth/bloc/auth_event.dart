part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogOut implements AuthEvent {
  const AuthEventLogOut();
}

class AuthEventSignUp implements AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthEventSignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class _AuthEventUserChanged extends AuthEvent {
  const _AuthEventUserChanged(this.user);

  final User user;
}

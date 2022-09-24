part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventLogIn implements AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
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

@immutable
class AuthEventInitialize implements AuthEvent {
  const AuthEventInitialize();
}

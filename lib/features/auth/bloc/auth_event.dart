part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

@immutable
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

class AuthEventPasswordReset implements AuthEvent {
  final String email;
  const AuthEventPasswordReset({required this.email});
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

// class AuthEventInitialize implements AuthEvent {
//   const AuthEventInitialize();
// }

final class _AuthEventUserChanged extends AuthEvent {
  const _AuthEventUserChanged(this.user);

  final User user;
}

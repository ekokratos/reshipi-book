part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

@immutable
abstract class AuthState extends Equatable {
  final bool isLoading;
  final AuthException? authException;
  final AuthStatus status;
  final User? user;

  const AuthState({
    required this.isLoading,
    this.authException,
    required this.status,
    this.user,
  });

  @override
  List<Object?> get props => [status, isLoading, authException];
}

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({
    required User user,
    required bool isLoading,
    AuthException? authException,
  }) : super(
          user: user,
          isLoading: isLoading,
          authException: authException,
          status: AuthStatus.authenticated,
        );

  @override
  List<Object?> get props => [user];
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated({
    required bool isLoading,
    AuthException? authException,
  }) : super(
          isLoading: isLoading,
          authException: authException,
          status: AuthStatus.unauthenticated,
        );
}

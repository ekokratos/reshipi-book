part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

@immutable
abstract class AuthState extends Equatable {
  final bool isLoading;
  final AuthException? authException;
  final AuthStatus status;
  final User? user;
  final DialogMessage? dialogMessage;

  const AuthState({
    required this.isLoading,
    this.authException,
    required this.status,
    this.user = User.empty,
    this.dialogMessage,
  });

  @override
  List<Object?> get props => [status, isLoading, authException];
}

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated({
    required User super.user,
    required super.isLoading,
    super.authException,
    super.dialogMessage,
  }) : super(
          status: AuthStatus.authenticated,
        );

  @override
  List<Object?> get props => [user];
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated({
    required super.isLoading,
    super.authException,
    super.dialogMessage,
  }) : super(
          status: AuthStatus.unauthenticated,
        );
}

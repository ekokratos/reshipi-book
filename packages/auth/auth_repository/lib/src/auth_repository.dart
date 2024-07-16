import 'package:auth_api/auth_api.dart';

class AuthRepository {
  const AuthRepository({
    required AuthApi authApi,
  }) : _authApi = authApi;

  final AuthApi _authApi;

  /// Provides [User] if authenticated, [User.empty] if not authenticated.
  User? get currentUser => _authApi.currentUser;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user => _authApi.user;

  /// Creates a new user with the provided [name], [email] and [password].
  ///
  /// Throws a [AuthException] if an exception occurs.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) =>
      _authApi.signUp(name: name, email: email, password: password);

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [AuthException] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _authApi.logInWithEmailAndPassword(email: email, password: password);

  /// Signs out the current user
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() => _authApi.logOut();

  /// Sends a password reset link to the provided email
  ///
  /// Throws a [AuthException] if an exception occurs.
  Future<void> resetPassword({required String email}) =>
      _authApi.resetPassword(email: email);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_book/features/auth/repository/auth_exception.dart';

class AuthRepository {
  AuthRepository() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  User? get currentUser => _firebaseAuth.currentUser;

  /// Creates a new user with the provided [name], [email] and [password].
  ///
  /// Throws a [AuthException] if an exception occurs.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ..user?.updateDisplayName(name);
      if (credentials.user != null) {
        await credentials.user?.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [AuthException] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    }
  }

  /// Signs out the current user
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

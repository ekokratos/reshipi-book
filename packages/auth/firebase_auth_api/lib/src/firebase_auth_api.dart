import 'package:auth_api/auth_api.dart' as auth_api;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi extends auth_api.AuthApi {
  FirebaseAuthApi({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  auth_api.User get currentUser =>
      _firebaseAuth.currentUser?.toUser ?? auth_api.User.empty;

  @override
  Stream<auth_api.User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? auth_api.User.empty : firebaseUser.toUser;
      return user;
    });
  }

  @override
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
      if (credentials.user != null) {
        await credentials.user?.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      throw auth_api.AuthException.from(e);
    }
  }

  @override
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
      throw auth_api.AuthException.from(e);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw auth_api.LogOutFailure();
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw auth_api.AuthException.from(e);
    }
  }
}

extension on User {
  /// Maps a [User] into a [auth_api.User].
  auth_api.User get toUser {
    return auth_api.User(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}

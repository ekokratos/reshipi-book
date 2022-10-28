import 'package:auth_api/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi extends AuthApi {
  FirebaseAuthApi() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

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
      throw AuthException.from(e);
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
      throw AuthException.from(e);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException.from(e);
    }
  }
}

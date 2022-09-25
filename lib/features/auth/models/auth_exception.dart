import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthException> authExceptionMapping = {
  'user-not-found': AuthExceptionUserNotFound(),
  'weak-password': AuthExceptionWeakPassword(),
  'invalid-email': AuthExceptionInvalidEmail(),
  'operation-not-allowed': AuthExceptionOperationNotAllowed(),
  'email-already-in-use': AuthExceptionEmailAlreadyInUse(),
  'requires-recent-login': AuthExceptionRequiresRecentLogin(),
  'no-current-user': AuthExceptionNoCurrentUser(),
};

@immutable
abstract class AuthException implements Exception {
  final String title;
  final String message;

  const AuthException({
    required this.title,
    required this.message,
  });

  factory AuthException.from(FirebaseAuthException exception) =>
      authExceptionMapping[exception.code.toLowerCase().trim()] ??
      AuthExceptionUnknown(exception);
}

@immutable
class AuthExceptionUnknown extends AuthException {
  final FirebaseAuthException innerFirebaseException;
  AuthExceptionUnknown(this.innerFirebaseException)
      : super(
          title: 'Authentication error',
          message:
              innerFirebaseException.message ?? 'Unknown authentication error',
        );
}

// auth/no-current-user

@immutable
class AuthExceptionNoCurrentUser extends AuthException {
  const AuthExceptionNoCurrentUser()
      : super(
          title: 'No current user!',
          message: 'No current user with this information was found!',
        );
}

// auth/requires-recent-login

@immutable
class AuthExceptionRequiresRecentLogin extends AuthException {
  const AuthExceptionRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          message:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// auth/operation-not-allowed

@immutable
class AuthExceptionOperationNotAllowed extends AuthException {
  const AuthExceptionOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          message: 'You cannot register using this method at this moment!',
        );
}

// auth/user-not-found

@immutable
class AuthExceptionUserNotFound extends AuthException {
  const AuthExceptionUserNotFound()
      : super(
          title: 'User not found',
          message: 'The given user was not found on the server!',
        );
}

// auth/weak-password

@immutable
class AuthExceptionWeakPassword extends AuthException {
  const AuthExceptionWeakPassword()
      : super(
          title: 'Weak password',
          message:
              'Please choose a stronger password consisting of more characters!',
        );
}

// auth/invalid-email

@immutable
class AuthExceptionInvalidEmail extends AuthException {
  const AuthExceptionInvalidEmail()
      : super(
          title: 'Invalid email',
          message: 'Please double check your email and try again!',
        );
}

// auth/email-already-in-use

@immutable
class AuthExceptionEmailAlreadyInUse extends AuthException {
  const AuthExceptionEmailAlreadyInUse()
      : super(
          title: 'Email already in use',
          message: 'Please choose another email to register with!',
        );
}

class LogOutFailure implements Exception {}



// abstract class AuthException implements Exception{
//  final String message;

// }
// class SignUpWithEmailAndPasswordFailure  extends AuthException{
 

//   const SignUpWithEmailAndPasswordFailure();

//   factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
//     switch (code) {
//       case 'invalid-email':
//         return const SignUpWithEmailAndPasswordFailure(
//           'Email is not valid or badly formatted.',
//         );
//       case 'user-disabled':
//         return const SignUpWithEmailAndPasswordFailure(
//           'This user has been disabled. Please contact support for help.',
//         );
//       case 'email-already-in-use':
//         return const SignUpWithEmailAndPasswordFailure(
//           'An account already exists for that email.',
//         );
//       case 'operation-not-allowed':
//         return const SignUpWithEmailAndPasswordFailure(
//           'Operation is not allowed.  Please contact support.',
//         );
//       case 'weak-password':
//         return const SignUpWithEmailAndPasswordFailure(
//           'Please enter a stronger password.',
//         );
//       default:
//         return const SignUpWithEmailAndPasswordFailure();
//     }
//   }
// }

// class LogInWithEmailAndPasswordFailure implements Exception {
//   const LogInWithEmailAndPasswordFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);

//   factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
//     switch (code) {
//       case 'invalid-email':
//         return const LogInWithEmailAndPasswordFailure(
//           'Email is not valid or badly formatted.',
//         );
//       case 'user-disabled':
//         return const LogInWithEmailAndPasswordFailure(
//           'This user has been disabled. Please contact support for help.',
//         );
//       case 'user-not-found':
//         return const LogInWithEmailAndPasswordFailure(
//           'Email is not found, please create an account.',
//         );
//       case 'wrong-password':
//         return const LogInWithEmailAndPasswordFailure(
//           'Incorrect password, please try again.',
//         );
//       default:
//         return const LogInWithEmailAndPasswordFailure();
//     }
//   }

//   final String message;
// }


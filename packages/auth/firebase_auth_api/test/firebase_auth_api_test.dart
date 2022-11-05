import 'package:auth_api/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseCore extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}

void main() {
  late FirebaseAuthApi sut;
  late FirebaseAuth firebaseAuth;
  const name = 'user name';
  const email = 'abc@test.com';
  const password = '*********';

  setUp((() {
    const options = FirebaseOptions(
      apiKey: 'apiKey',
      appId: 'appId',
      messagingSenderId: 'messagingSenderId',
      projectId: 'projectId',
    );
    final platformApp = FirebaseAppPlatform(defaultFirebaseAppName, options);
    final firebaseCore = MockFirebaseCore();

    when(() => firebaseCore.apps).thenReturn([platformApp]);
    when(firebaseCore.app).thenReturn(platformApp);
    when(
      () => firebaseCore.initializeApp(
        name: defaultFirebaseAppName,
        options: options,
      ),
    ).thenAnswer((_) async => platformApp);

    Firebase.delegatePackingProperty = firebaseCore;

    firebaseAuth = MockFirebaseAuth();
    sut = FirebaseAuthApi(firebaseAuth: firebaseAuth);
  }));

  test('creates FirebaseAuth instance internally when not injected', () {
    expect(FirebaseAuthApi.new, isNot(throwsException));
  });

  group('currentUser', () {
    test('returns logged in user', () {
      final user = MockUser();
      when(() => firebaseAuth.currentUser).thenAnswer((_) => user);
      expect(sut.currentUser, user);
    });

    test('returns null if not authenticated', () {
      when(() => firebaseAuth.currentUser).thenAnswer((_) => null);
      expect(sut.currentUser, null);
    });
  });

  group('signUp', () {
    final credentials = MockUserCredential();
    final User mockUser = MockUser();

    setUp(() {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => credentials);

      when(() => credentials.user).thenReturn(mockUser);
      when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});
    });

    test('calls createUserWithEmailAndPassword', () async {
      await sut.signUp(email: email, password: password, name: name);
      verify(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test('succeeds when createUserWithEmailAndPassword succeeds', () async {
      expect(
        sut.signUp(email: email, password: password, name: name),
        completes,
      );
    });
    test(
        'throws AuthException'
        'when createUserWithEmailAndPassword throws', () async {
      when(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(FirebaseAuthException(code: ''));
      expect(
        sut.signUp(email: email, password: password, name: name),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('logInWithEmailAndPassword', () {
    setUp(() {
      when(() => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => MockUserCredential());
    });

    test('calls signInWithEmailAndPassword', () async {
      await sut.logInWithEmailAndPassword(email: email, password: password);
      verify(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test('succeeds when signInWithEmailAndPassword succeeds', () {
      expect(
        sut.logInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        completes,
      );
    });

    test(
        'throws AuthException '
        'when signInWithEmailAndPassword throws', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(FirebaseAuthException(code: ''));
      expect(
        sut.logInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('logOut', () {
    setUp(() {
      when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
    });
    test('calls signOut', () async {
      await sut.logOut();
      verify(() => firebaseAuth.signOut()).called(1);
    });

    test('succeeds when signOut succeeds', () {
      expect(sut.logOut(), completes);
    });

    test('throws LogOutFailure when signOut throws', () async {
      when(() => firebaseAuth.signOut()).thenThrow(Exception());
      expect(
        sut.logOut(),
        throwsA(isA<LogOutFailure>()),
      );
    });
  });

  group('resetPassword', () {
    setUp(() {
      when(() => firebaseAuth.sendPasswordResetEmail(
            email: email,
          )).thenAnswer((_) async {});
    });

    test('calls sendPasswordResetEmail', () async {
      await sut.resetPassword(email: email);
      verify(
        () => firebaseAuth.sendPasswordResetEmail(
          email: email,
        ),
      ).called(1);
    });

    test('succeeds when sendPasswordResetEmail succeeds', () {
      expect(
        sut.resetPassword(
          email: email,
        ),
        completes,
      );
    });

    test(
        'throws AuthException '
        'when signInWithEmailAndPassword throws', () async {
      when(
        () => firebaseAuth.sendPasswordResetEmail(
          email: any(named: 'email'),
        ),
      ).thenThrow(FirebaseAuthException(code: ''));

      expect(
        sut.resetPassword(email: email),
        throwsA(isA<AuthException>()),
      );
    });
  });
}

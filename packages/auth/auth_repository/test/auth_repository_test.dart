import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthApi extends Mock implements AuthApi {}

class MockUser extends Fake implements User {}

void main() {
  late AuthApi api;
  late AuthRepository sut;

  const name = 'User Name';
  const email = 'abc@test.com';
  const password = '*********';

  AuthRepository createSubject() => AuthRepository(authApi: api);

  setUp(() {
    api = MockAuthApi();
    sut = createSubject();

    when(() => api.signUp(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'))).thenAnswer((_) async {});
    when(() => api.logInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'))).thenAnswer((_) async {});
    when(() => api.logOut()).thenAnswer((_) async {});
    when(() => api.resetPassword(email: any(named: 'email')))
        .thenAnswer((_) async {});
  });

  test('Constructor works properly', () {
    expect(createSubject, returnsNormally);
  });

  group('currentUser:', () {
    test('returns logged in user', () {
      final user = MockUser();
      when(() => api.currentUser).thenAnswer((_) => user);
      expect(sut.currentUser, user);
    });
    test('returns null if not authenticated', () {
      when(() => api.currentUser).thenAnswer((_) => null);
      expect(sut.currentUser, null);
    });
  });

  test('signUp makes correct api request', (() {
    expect(sut.signUp(name: name, email: email, password: password), completes);
    verify(() => api.signUp(name: name, email: email, password: password))
        .called(1);
  }));

  test('logInWithEmailAndPassword makes correct api request', (() {
    expect(sut.logInWithEmailAndPassword(email: email, password: password),
        completes);
    verify(() =>
            api.logInWithEmailAndPassword(email: email, password: password))
        .called(1);
  }));

  test('logOut makes correct api request', (() {
    expect(sut.logOut(), completes);
    verify(() => api.logOut()).called(1);
  }));

  test('resetPassword makes correct api request', (() {
    expect(sut.resetPassword(email: email), completes);
    verify(() => api.resetPassword(email: email)).called(1);
  }));
}

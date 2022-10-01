// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationRepository', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = AuthenticationRepository();
    });

    test('can be instantiated', () {
      expect(AuthenticationRepository(), isNotNull);
    });

    group('Login', () {
      const username = 'username';
      const password = 'password';

      test('returns authenticated status', () {
        authenticationRepository.logIn(username: username, password: password);
        expect(
          authenticationRepository.status,
          emitsInOrder([
            AuthenticationStatus.unauthenticated,
            AuthenticationStatus.authenticated
          ]),
        );
      });
    });

    group('Logout', () {
      const username = 'username';
      const password = 'password';

      test('returns unauthenticated status', () async {
        await authenticationRepository.logIn(
          username: username,
          password: password,
        );
        authenticationRepository.logOut();
        expect(
          authenticationRepository.status,
          emitsInOrder([
            AuthenticationStatus.unauthenticated,
            AuthenticationStatus.authenticated,
            AuthenticationStatus.unauthenticated,
          ]),
        );
      });
    });
  });
}

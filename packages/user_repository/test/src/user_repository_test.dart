// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('UserRepository', () {
    late UserRepository userRepository;

    setUp(() {
      userRepository = UserRepository();
    });

    test('can be instantiated', () {
      expect(UserRepository(), isNotNull);
    });

    group('getUser', () {
      test('returns user', () {
        expect(userRepository.getUser(), isNotNull);
      });
    });
  });
}

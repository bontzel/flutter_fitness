// ignore_for_file: prefer_const_constructors

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:workouts_api/src/models/models.dart';

void main() {
  group('Workout', () {
    group('fromJson', () {
      test('parse works', () {
        expect(
          () => Workout.fromJson(<String, dynamic>{
            'id': 'dummid',
            'name': 'dummyname',
          }),
          returnsNormally,
        );
      });
    });
  });
}

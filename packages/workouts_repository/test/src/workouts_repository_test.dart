// ignore_for_file: prefer_const_constructors
import 'dart:ffi';

import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:workouts_api/workouts_api.dart';
import 'package:workouts_repository/src/workouts_repository.dart';

class MockWorkoutsAPI extends Mock implements WorkoutsApi {}

class MockWorkout extends Mock implements Workout {}

void main() {
  group('WorkoutsRepository', () {
    late WorkoutsApi workoutsApi;
    late WorkoutsRepository workoutsRepository;

    setUp(() {
      workoutsApi = MockWorkoutsAPI();
      workoutsRepository = WorkoutsRepository(workoutsApi: workoutsApi);
    });

    group('getWorkouts', () {
      final workout = MockWorkout();
      when(() => workout.id).thenReturn('id');
      when(() => workout.name).thenReturn('name');
      when(() => workoutsApi.getWorkouts()).thenAnswer(
        (_) => Stream.value([workout]),
      );
      final actual = workoutsRepository.getWorkouts();
      expect(
        actual,
        Workout(id: 'id', name: 'name'),
      );
    });

    group('deleteWorkout', () {
      final id = "id";
      when(() => workoutsApi.deleteWorkout(id)).thenReturn(() { await void; });
      final actual = workoutsRepository.getWorkouts();
      expect(
        actual,
        Workout(id: 'id', name: 'name'),
      );
    });
  });
}

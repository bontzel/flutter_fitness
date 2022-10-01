// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:workouts_api/workouts_api.dart' as workouts_api;
import 'package:workouts_repository/src/workouts_repository.dart';

class MockWorkoutsAPI extends Mock implements workouts_api.WorkoutsApi {}

class MockWorkout extends Mock implements workouts_api.Workout {}

void main() {
  group('WorkoutsRepository', () {
    late workouts_api.WorkoutsApi workoutsApi;
    late WorkoutsRepository workoutsRepository;

    setUp(() {
      workoutsApi = MockWorkoutsAPI();
      workoutsRepository = WorkoutsRepository(workoutsApi: workoutsApi);
    });

    group('getWorkouts', () {
      test(
        'return correct stream of workouts',
        () async {
          final workout = MockWorkout();

          when(() => workout.id).thenReturn('id');
          when(() => workout.name).thenReturn('name');

          when(() => workoutsApi.getWorkouts()).thenAnswer(
            (_) => Stream.value([workout]),
          );
          final actual = workoutsRepository.getWorkouts();
          expect(
            actual,
            emitsInOrder(
              [
                [workout]
              ],
            ),
          );
        },
      );
    });

    group('deleteWorkout', () {
      test(
        'delete workout returns normally',
        () async {
          const id = 'id';
          when(() => workoutsApi.deleteWorkout(id))
              .thenAnswer((_) => Future<void>.value());
          final actual = workoutsRepository.deleteWorkout(id);
          expect(
            actual,
            completion(equals(null)),
          );
        },
      );
    });
  });
}

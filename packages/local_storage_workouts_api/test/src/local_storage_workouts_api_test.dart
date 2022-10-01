// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_workouts_api/local_storage_workouts_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouts_api/workouts_api.dart';

void main() {
  group('LocalStorageWorkoutsApi', () {
    late LocalStorageWorkoutsApi localStorageWorkoutsApi;
    final workout = Workout(name: 'testName');

    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});

      localStorageWorkoutsApi = LocalStorageWorkoutsApi(
        plugin: await SharedPreferences.getInstance(),
      );
      await localStorageWorkoutsApi.deleteAllWorkouts();
    });

    group('createWorkout', () {
      test('actually adds workout', () {
        localStorageWorkoutsApi.createWorkout(workout);
        expect(
          localStorageWorkoutsApi.getWorkouts(),
          emitsInOrder(
            [
              [workout],
            ],
          ),
        );
      });
    });

    group('deleteWorkout', () {
      test('actually deletes workout', () async {
        await localStorageWorkoutsApi.deleteWorkout(workout.id);
        expect(
          localStorageWorkoutsApi.getWorkouts(),
          emitsInOrder(
            [
              List<Workout>.empty(),
            ],
          ),
        );
      });
    });
  });
}

import 'package:workouts_api/workouts_api.dart';

/// {@template workouts_api}
/// The interface for an API that provides access to a list of todos.
/// {@endtemplate}
abstract class WorkoutsApi {
  /// {@macro workout_api}
  const WorkoutsApi();

  /// Provides a [Stream] of all workouts.
  Stream<List<Workout>> getWorkouts();

  /// Saves a [Workout].
  ///
  /// If a [Workout] with the same id already exists, it will be replaced.
  Future<void> createWorkout(Workout workout);

  /// Deletes the todo with the given id.
  ///
  /// If no workout with the given id exists, a [WorkoutNotFoundException]
  /// error is thrown.
  Future<void> deleteWorkout(String id);
}

/// Error thrown when a [Workout] with a given id is not found.
class WorkoutNotFoundException implements Exception {}

import 'dart:async';
import 'package:workouts_api/workouts_api.dart';

/// {@template todos_repository}
/// A repository that handles workout related requests.
/// {@endtemplate}
class WorkoutsRepository {
  /// {@macro todos_repository}
  const WorkoutsRepository({
    required WorkoutsApi workoutsApi,
  }) : _workoutsApi = workoutsApi;

  final WorkoutsApi _workoutsApi;

  /// Provides a [Stream] of all todos.
  Stream<List<Workout>> getWorkouts() => _workoutsApi.getWorkouts();

  /// Deletes the workout with the given id.
  ///
  /// If no workout with the given id exists,
  /// a [WorkoutNotFoundException] error is
  /// thrown.
  Future<void> deleteWorkout(String id) => _workoutsApi.deleteWorkout(id);

  /// Create a [Workout].
  ///
  /// If a [Workout] with the same id already exists, it will be replaced.
  Future<void> createWorkout(Workout workout) =>
      _workoutsApi.createWorkout(workout);
}

import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouts_api/workouts_api.dart';

/// {@template local_storage_todos_api}
/// A Flutter implementation of the [WorkoutsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageWorkoutsApi extends WorkoutsApi {
  /// {@macro local_storage_todos_api}
  LocalStorageWorkoutsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _workoutsStreamController =
      BehaviorSubject<List<Workout>>.seeded(const []);

  /// The key used for storing the wokouts locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kWorkoutsCollectionKey = '__workouts_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final workoutsJson = _getValue(kWorkoutsCollectionKey);
    if (workoutsJson != null) {
      final workouts =
          List<Map<String, dynamic>>.from(json.decode(workoutsJson) as List)
              .map(
                (jsonMap) => Workout.fromJson(
                  Map<String, dynamic>.from(jsonMap),
                ),
              )
              .toList();
      _workoutsStreamController.add(workouts);
    } else {
      _workoutsStreamController.add(const []);
    }
  }

  @override
  Stream<List<Workout>> getWorkouts() =>
      _workoutsStreamController.asBroadcastStream();

  @override
  Future<void> createWorkout(Workout workout) {
    final workouts = [..._workoutsStreamController.value];
    final workoutIndex = workouts.indexWhere((t) => t.id == workout.id);
    if (workoutIndex >= 0) {
      workouts[workoutIndex] = workout;
    } else {
      workouts.add(workout);
    }

    _workoutsStreamController.add(workouts);
    return _setValue(kWorkoutsCollectionKey, json.encode(workouts));
  }

  @override
  Future<void> deleteWorkout(String id) async {
    final workouts = [..._workoutsStreamController.value];
    final workoutIndex = workouts.indexWhere((t) => t.id == id);
    if (workoutIndex == -1) {
      throw WorkoutNotFoundException();
    } else {
      workouts.removeAt(workoutIndex);
      _workoutsStreamController.add(workouts);
      return _setValue(kWorkoutsCollectionKey, json.encode(workouts));
    }
  }

  /// Convenience method to reset storage
  @visibleForTesting
  Future<void> deleteAllWorkouts() async {
    _workoutsStreamController.add([]);
    return _setValue(kWorkoutsCollectionKey, json.encode([]));
  }
}

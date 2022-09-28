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

  final _todoStreamController = BehaviorSubject<List<Workout>>.seeded(const []);

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final workoutsJson = _getValue(kTodosCollectionKey);
    if (workoutsJson != null) {
      final workouts = List<Map>.from(json.decode(workoutsJson) as List)
          .map((jsonMap) => Workout.fromJson(Map<String, dynamic>
            .from(jsonMap),
        ),
      )
          .toList();
      _todoStreamController.add(workouts);
    } else {
      _todoStreamController.add(const []);
    }
  }

  @override
  Stream<List<Workout>> getWorkouts() => _todoStreamController
                                              .asBroadcastStream();

  @override
  Future<void> createWorkout(Workout todo) {
    final workouts = [..._todoStreamController.value];
    final workoutIndex = workouts.indexWhere((t) => t.id == todo.id);
    if (workoutIndex >= 0) {
      workouts[workoutIndex] = todo;
    } else {
      workouts.add(todo);
    }

    _todoStreamController.add(workouts);
    return _setValue(kTodosCollectionKey, json.encode(workouts));
  }

  @override
  Future<void> deleteWorkout(String id) async {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw WorkoutNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _setValue(kTodosCollectionKey, json.encode(todos));
    }
  }
}

part of 'workouts_bloc.dart';

enum WorkoutsStatus { initial, loading, success, failure}

class WorkoutsState extends Equatable {
  const WorkoutsState({
    this.status = WorkoutsStatus.initial,
    this.workouts = const [],
    this.lastDeletedWorkout,
  });

  final WorkoutsStatus status;
  final List<Workout> workouts;
  final Workout? lastDeletedWorkout;

  WorkoutsState copyWith({
    WorkoutsStatus Function()? status,
    List<Workout> Function()? workouts,
    Workout? Function()? lastDeletedWorkout,
  }) {
    return WorkoutsState(
      status: status != null ? status() : this.status,
      workouts: workouts != null ? workouts() : this.workouts,
      lastDeletedWorkout:
        lastDeletedWorkout != null ?
          lastDeletedWorkout() : this.lastDeletedWorkout,
    );
  }

  @override
  String toString() {
    return '''WorkoutsState { status: $status, workouts: ${workouts.length} }''';
  }

  @override
  List<Object> get props => [status, workouts];
}


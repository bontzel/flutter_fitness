import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workouts_api/workouts_api.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc({
    required this.workoutsRepository,
  }) : super(const WorkoutsState()) {
    on<WorkoutsSubscriptionRequested>(_onWorkoutsSubscriptionRequested);
    on<WorkoutDeleteRequested>(_onWorkoutDeleted);
    on<WorkoutsUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final WorkoutsRepository workoutsRepository;

  Future<void> _onWorkoutsSubscriptionRequested(
    WorkoutsSubscriptionRequested event,
    Emitter<WorkoutsState> emit,
  ) async {
    emit(state.copyWith(status: () => WorkoutsStatus.loading));

    await emit.forEach<List<Workout>>(
      workoutsRepository.getWorkouts(),
      onData: (workouts) => state.copyWith(
        status: () => WorkoutsStatus.success,
        workouts: () => workouts,
      ),
      onError: (_, __) => state.copyWith(
        status: () => WorkoutsStatus.failure,
      ),
    );
  }

  Future<void> _onWorkoutDeleted(
    WorkoutDeleteRequested event,
    Emitter<WorkoutsState> emit,
  ) async {
    emit(state.copyWith(lastDeletedWorkout: () => event.workout));
    await workoutsRepository.deleteWorkout(event.workout.id);
  }

  Future<void> _onUndoDeletionRequested(
    WorkoutsUndoDeletionRequested event,
    Emitter<WorkoutsState> emit,
  ) async {
    assert(
      state.lastDeletedWorkout != null,
      'Last deleted workout can not be null.',
    );

    final workout = state.lastDeletedWorkout!;
    emit(state.copyWith(lastDeletedWorkout: () => null));
    await workoutsRepository.createWorkout(workout);
  }
}

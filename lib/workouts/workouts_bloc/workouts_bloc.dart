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
}

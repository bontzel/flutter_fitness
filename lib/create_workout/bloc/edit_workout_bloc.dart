import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fitness/create_workout/create_workout.dart';
import 'package:formz/formz.dart';
import 'package:workouts_api/workouts_api.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'edit_workout_event.dart';
part 'edit_workout_state.dart';

class EditWorkoutBloc extends Bloc<CreateWorkoutEvent, EditWorkoutState> {
  EditWorkoutBloc({
    required WorkoutsRepository workoutsRepository,
  })  : _workoutsRepository = workoutsRepository,
        super(const EditWorkoutState()) {
    on<WorkoutNameChanged>(_onNameChanged);
    on<WorkoutSubmitted>(_onSubmitted);
  }

  final WorkoutsRepository _workoutsRepository;

  void _onNameChanged(
    WorkoutNameChanged event,
    Emitter<EditWorkoutState> emit,
  ) {
    final name = WorkoutName.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name]),
      ),
    );
  }

  Future<void> _onSubmitted(
    WorkoutSubmitted event,
    Emitter<EditWorkoutState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _workoutsRepository
            .createWorkout(Workout(name: state.name.value));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}

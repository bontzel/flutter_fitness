// ignore_for_file: public_member_api_docs

part of 'edit_workout_bloc.dart';

abstract class CreateWorkoutEvent extends Equatable {
  const CreateWorkoutEvent();

  @override
  List<Object> get props => [];
}

class WorkoutNameChanged extends CreateWorkoutEvent {
  const WorkoutNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class WorkoutSubmitted extends CreateWorkoutEvent {
  const WorkoutSubmitted();
}

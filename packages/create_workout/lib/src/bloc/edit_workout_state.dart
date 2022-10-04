// ignore_for_file: public_member_api_docs

part of 'edit_workout_bloc.dart';

class EditWorkoutState extends Equatable {
  const EditWorkoutState({
    this.status = FormzStatus.pure,
    this.name = const WorkoutName.pure(),
  });

  final FormzStatus status;
  final WorkoutName name;

  EditWorkoutState copyWith({
    FormzStatus? status,
    WorkoutName? name,
  }) {
    return EditWorkoutState(
      status: status ?? this.status,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [status, name];
}

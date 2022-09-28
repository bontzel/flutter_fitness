part of 'workouts_bloc.dart';

abstract class WorkoutsEvent extends Equatable {
  const WorkoutsEvent();
  @override
  List<Object?> get props => [];
}

class WorkoutsSubscriptionRequested extends WorkoutsEvent {
  const WorkoutsSubscriptionRequested();
}

class WorkoutDeleteRequested extends WorkoutsEvent {
  const WorkoutDeleteRequested(this.workout);

  final Workout workout;

  @override
  List<Object> get props => [workout];
}

class WorkoutsUndoDeletionRequested extends WorkoutsEvent {
  const WorkoutsUndoDeletionRequested();
}
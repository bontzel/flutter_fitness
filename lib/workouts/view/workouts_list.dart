import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fitness/workouts/widgets/widgets.dart';
import 'package:flutter_fitness/workouts/workouts_bloc/workouts_bloc.dart';

class WorkoutsListPage extends StatelessWidget {
  const WorkoutsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutsBloc, WorkoutsState>(
      listenWhen: (previous, current) =>
          previous.lastDeletedWorkout != current.lastDeletedWorkout &&
          current.lastDeletedWorkout != null,
      listener: (context, state) {
        final deletedWorkout = state.lastDeletedWorkout!;
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                '${deletedWorkout.name} has been deleted',
              ),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  messenger.hideCurrentSnackBar();
                  context
                      .read<WorkoutsBloc>()
                      .add(const WorkoutsUndoDeletionRequested());
                },
              ),
            ),
          );
      },
      child: BlocBuilder<WorkoutsBloc, WorkoutsState>(
        builder: (context, state) {
          switch (state.status) {
            case WorkoutsStatus.initial:
              return const Center(child: Text('Initial'));
            case WorkoutsStatus.failure:
              return const Center(child: Text('failed to fetch workouts'));
            case WorkoutsStatus.success:
              if (state.workouts.isEmpty) {
                return const Center(child: Text('no workouts'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return WorkoutListItem(workout: state.workouts[index]);
                },
                itemCount: state.workouts.length,
              );
            case WorkoutsStatus.loading:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

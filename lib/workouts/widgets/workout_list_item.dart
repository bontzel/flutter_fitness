import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fitness/workouts/workouts_bloc/workouts_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workouts_api/workouts_api.dart';

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context
                    .read<WorkoutsBloc>()
                    .add(WorkoutDeleteRequested(workout));
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          title: Text(workout.name),
        ),
      ),
    );
  }
}

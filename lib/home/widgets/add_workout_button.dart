import 'package:flutter/material.dart';
import 'package:flutter_fitness/create_workout/create_workout.dart';

class AddWorkoutButton extends StatelessWidget {
  const AddWorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          CreateWorkoutPage.route(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

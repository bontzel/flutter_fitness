// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AddWorkoutButton extends StatelessWidget {
  AddWorkoutButton({super.key, required this.createWorkout});
  final Widget createWorkout;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => createWorkout),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

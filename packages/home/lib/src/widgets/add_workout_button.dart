// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AddWorkoutButton extends StatelessWidget {
  const AddWorkoutButton({super.key, required this.createWorkoutRoute});
  final Route<void> createWorkoutRoute;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          createWorkoutRoute,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

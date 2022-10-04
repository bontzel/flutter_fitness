// ignore_for_file: public_member_api_docs

import 'package:create_workout/src/bloc/edit_workout_bloc.dart';
import 'package:create_workout/src/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workouts_repository/workouts_repository.dart';

class CreateWorkoutPage extends StatelessWidget {
  const CreateWorkoutPage({super.key});

  // ignore: strict_raw_type
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CreateWorkoutPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Workout')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return EditWorkoutBloc(
              workoutsRepository:
                  RepositoryProvider.of<WorkoutsRepository>(context),
            );
          },
          child: const CreateWorkoutForm(),
        ),
      ),
    );
  }
}

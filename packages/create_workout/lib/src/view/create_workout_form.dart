import 'package:create_workout/src/bloc/edit_workout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateWorkoutForm extends StatelessWidget {
  const CreateWorkoutForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditWorkoutBloc, EditWorkoutState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Create Workout Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _CreateButton(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWorkoutBloc, EditWorkoutState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('createWorkoutForm_nameInput_textField'),
          onChanged: (username) =>
              context.read<EditWorkoutBloc>().add(WorkoutNameChanged(username)),
          decoration: InputDecoration(
            labelText: 'name',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditWorkoutBloc, EditWorkoutState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('createWorkoutForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<EditWorkoutBloc>()
                            .add(const WorkoutSubmitted());
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Create'),
              );
      },
    );
  }
}

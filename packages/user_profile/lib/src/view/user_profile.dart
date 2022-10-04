// ignore_for_file: public_member_api_docs

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile/src/authentication/bloc.dart';
import 'package:user_repository/user_repository.dart';

/// User profile widget to show user information and the possiblity to logout
class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
      child: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  final userId = context.select(
                    (AuthenticationBloc bloc) => bloc.state.user.id,
                  );
                  return Text('UserID: $userId');
                },
              ),
              ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs

import 'package:create_workout/create_workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home.dart';
import 'package:user_profile/user_profile.dart';
import 'package:workouts_list/workouts_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static List<String> titles = [
    'User Profile',
    'Workouts',
  ];

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedTab.index])),
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          UserProfile(),
          WorkoutsListPage(),
        ],
      ),
      floatingActionButton: selectedTab == HomeTab.workouts
          ? AddWorkoutButton(
              createWorkout: const CreateWorkoutPage(),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.userProfile,
              icon: const Icon(
                Icons.settings,
              ),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.workouts,
              icon: const Icon(
                Icons.list,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home.dart';
import 'package:user_profile/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.workoutsListProvider,
    required this.createWorkout,
    required this.getUndoDeleteListener,
    required this.userLogout,
  });
  final Widget Function() workoutsListProvider;
  final Widget createWorkout;
  final MultiBlocListener Function(Widget) getUndoDeleteListener;
  final List<Widget> userLogout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(
        workoutsListProvider: workoutsListProvider,
        createWorkout: createWorkout,
        getUndoDeleteListener: getUndoDeleteListener,
        userLogout: userLogout,
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.workoutsListProvider,
    required this.createWorkout,
    required this.getUndoDeleteListener,
    required this.userLogout,
  });
  final Widget Function() workoutsListProvider;
  final Widget createWorkout;
  final MultiBlocListener Function(Widget) getUndoDeleteListener;
  final List<Widget> userLogout;

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
        children: [
          UserProfile(userLogout: userLogout),
          workoutsListProvider(),
        ],
      ),
      floatingActionButton: selectedTab == HomeTab.workouts
          ? AddWorkoutButton(
              createWorkout: createWorkout,
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

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home.dart';

class HomePage extends StatefulWidget {
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

  // ignore: strict_raw_type
  static Route route(
    Widget Function() workoutsListProvider,
    Widget createWorkout,
    MultiBlocListener Function(Widget) getUndoDeleteListener,
    List<Widget> userLogout,
  ) {
    return MaterialPageRoute<void>(
      builder: (_) => HomePage(
        workoutsListProvider: workoutsListProvider,
        createWorkout: createWorkout,
        getUndoDeleteListener: getUndoDeleteListener,
        userLogout: userLogout,
      ),
    );
  }

  Widget userProfile(List<Widget> userLogout) {
    return UserProfile(userLogout: userLogout);
  }

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(
        tabsProvider: [
          userProfile(userLogout),
          workoutsListProvider(),
        ],
        createWorkout: createWorkout,
        getUndoDeleteListener: getUndoDeleteListener,
      );
}

class _HomePageState extends State<HomePage> {
  _HomePageState({
    required this.getUndoDeleteListener,
    required this.tabsProvider,
    required this.createWorkout,
  });
  final List<Widget> tabsProvider;
  final Widget createWorkout;
  final MultiBlocListener Function(Widget) getUndoDeleteListener;

  int _selectedIndex = 0;

  static const List<Text> _titles = [
    Text('User Panel'),
    Text('Workouts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _titles[_selectedIndex]),
      body: getUndoDeleteListener(
        Center(
          child: tabsProvider[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'User Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Workouts',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? AddWorkoutButton(
              createWorkout: createWorkout,
            )
          : null,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

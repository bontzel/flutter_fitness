import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fitness/home/home.dart';
import 'package:flutter_fitness/workouts/view/view.dart';
import 'package:flutter_fitness/workouts/workouts_bloc/workouts_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // ignore: strict_raw_type
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget Function()> _tabPages = [
    userProfile,
    workouts,
  ];

  static const List<Text> _titles = [
    Text('User Panel'),
    Text('Workouts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _titles[_selectedIndex]),
      body: MultiBlocListener(
        listeners: [
          BlocListener<WorkoutsBloc, WorkoutsState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedWorkout != current.lastDeletedWorkout &&
                current.lastDeletedWorkout != null,
            listener: (context, state) {
              final deletedWorkout = state.lastDeletedWorkout!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      '${deletedWorkout.name} has been deleted',
                    ),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<WorkoutsBloc>()
                            .add(const WorkoutsUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: Center(
          child: _tabPages[_selectedIndex](),
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
      floatingActionButton:
          _selectedIndex == 1 ? const AddWorkoutButton() : null,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static Widget workouts() {
    return const WorkoutsListPage();
  }

  static Widget userProfile() {
    return const UserProfile();
  }
}

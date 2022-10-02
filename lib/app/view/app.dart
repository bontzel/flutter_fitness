import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fitness/authentication/authentication.dart';
import 'package:flutter_fitness/create_workout/view/view.dart';
import 'package:flutter_fitness/login/login.dart';
import 'package:flutter_fitness/splash/splash.dart';
import 'package:flutter_fitness/workouts/view/view.dart';
import 'package:flutter_fitness/workouts/workouts_bloc/workouts_bloc.dart';
import 'package:home/home.dart' as home;
import 'package:user_repository/user_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.workoutsRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final WorkoutsRepository workoutsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: workoutsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<WorkoutsBloc>(
            create: (_) => WorkoutsBloc(
              workoutsRepository: workoutsRepository,
            )..add(const WorkoutsSubscriptionRequested()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  MultiBlocListener getUndoDeleteListener(Widget childWidget) {
    return MultiBlocListener(
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
      child: childWidget,
    );
  }

  List<Widget> getUserLogout() {
    return <Widget>[
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  home.HomePage.route(
                    WorkoutsListPage.new,
                    CreateWorkoutPage(),
                    getUndoDeleteListener,
                    getUserLogout(),
                  ),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

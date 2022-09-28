import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fitness/app/app.dart';
import 'package:flutter_fitness/bootstrap.dart';
import 'package:local_storage_workouts_api/local_storage_workouts_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';
import 'package:workouts_repository/workouts_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final workoutsApi = LocalStorageWorkoutsApi(
    plugin: await SharedPreferences.getInstance(),
  );

  Bloc.observer = AppBlocObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
      workoutsRepository: WorkoutsRepository(workoutsApi: workoutsApi),
    ),
  );
}

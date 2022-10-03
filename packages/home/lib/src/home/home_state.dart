// ignore_for_file: public_member_api_docs

part of 'home_cubit.dart';

enum HomeTab { userProfile, workouts }

class HomeState extends Equatable {
  const HomeState({this.tab = HomeTab.userProfile});

  final HomeTab tab;

  @override
  List<Object?> get props => [tab];
}

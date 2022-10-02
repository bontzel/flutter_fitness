import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/authentication_bloc.dart';

/// User profile widget to show user information
class UserProfile extends StatelessWidget {
  // ignore: public_member_api_docs
  const UserProfile({
    super.key,
    required this.userLogout,
  });
  final List<Widget> userLogout;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: userLogout,
      ),
    );
  }
}

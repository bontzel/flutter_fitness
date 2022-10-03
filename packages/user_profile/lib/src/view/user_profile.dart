import 'dart:async';

import 'package:flutter/material.dart';

/// User profile widget to show user information and the possiblity to logout
class UserProfile extends StatelessWidget {
  // ignore: public_member_api_docs
  const UserProfile({
    super.key,
    required this.userLogout,
  });

  /// List of widgets responsible with logout
  final List<Widget> userLogout;
  final void Function() userLogoutAction;

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

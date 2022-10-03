import 'dart:async';

import 'package:rxdart/rxdart.dart';

/// The possible authentication statuses
enum AuthenticationStatus {
  /// Error or any other untreated authentication statuses
  unknown,

  /// User is authenticated
  authenticated,

  /// User is not authenticated
  unauthenticated
}

/// Repository exposing methods to the authentication service
class AuthenticationRepository {
  final _controller = BehaviorSubject<AuthenticationStatus>();

  /// A [Stream] to query the authentication status
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  /// Method exposing login service
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  /// Method exposing logout service
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  /// Cleanup method
  void dispose() => _controller.close();
}

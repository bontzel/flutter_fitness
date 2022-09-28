import 'package:equatable/equatable.dart';

/// Class used to define the user model.
class User extends Equatable {
  /// User constructor
  const User(this.id);

  /// Identifier of the [User].
  final String id;

  @override
  List<Object> get props => [id];

  /// Convenience method to return empty user.
  static const empty = User('-');
}

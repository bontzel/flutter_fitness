import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'workout.g.dart';

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;

/// {@template workout}
/// A single workout item.
///
/// Contains a [name] and [id]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Workout]s are immutable and can be
/// serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Workout extends Equatable {
  /// {@macro workout}
  Workout({
    String? id,
    required this.name,
  }) : assert(
    id == null || id.isNotEmpty,
  'id cannot be null and should be empty',
  ),
  id = id ?? const Uuid().v4();

  /// The unique identifier of the workout.
  ///
  /// Cannot be empty.
  final String id;

  /// The name of the workout.
  ///
  /// Note that the name may be empty.
  final String name;

  /// Deserializes the given [JsonMap] into a [Workout].
  static Workout fromJson(JsonMap json) => _$WorkoutFromJson(json);

  /// Converts this [Workout] into a [JsonMap].
  JsonMap toJson() => _$WorkoutToJson(this);

  @override
  List<Object> get props => [id, name];
}

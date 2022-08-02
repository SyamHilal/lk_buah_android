import 'package:collection/collection.dart';

class Query {
  int? weight;
  String? courier;
  String? origin;
  String? destination;

  Query({this.weight, this.courier, this.origin, this.destination});

  @override
  String toString() {
    return 'Query(weight: $weight, courier: $courier, origin: $origin, destination: $destination)';
  }

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        weight: json['weight'] as int?,
        courier: json['courier'] as String?,
        origin: json['origin'].toString(),
        destination: json['destination'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'courier': courier,
        'origin': origin,
        'destination': destination,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Query) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      weight.hashCode ^
      courier.hashCode ^
      origin.hashCode ^
      destination.hashCode;
}

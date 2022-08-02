import 'package:collection/collection.dart';

class StatusOrder {
  int? id;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;

  StatusOrder({this.id, this.name, this.createdAt, this.updatedAt});

  @override
  String toString() {
    return 'StatusOrder(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory StatusOrder.fromJson(Map<String, dynamic> json) => StatusOrder(
        id: json['id'] as int?,
        name: json['name'] as String?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StatusOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
}

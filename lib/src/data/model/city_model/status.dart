import 'package:collection/collection.dart';

class Status {
  int? code;
  String? description;

  Status({this.code, this.description});

  @override
  String toString() => 'Status(code: $code, description: $description)';

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json['code'] as int?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Status) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode;
}

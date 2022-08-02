import 'package:collection/collection.dart';

class Query {
  String? province;

  Query({this.province});

  @override
  String toString() => 'Query(province: $province)';

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        province: json['province'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'province': province,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Query) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => province.hashCode;
}

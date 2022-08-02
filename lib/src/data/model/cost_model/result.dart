import 'package:collection/collection.dart';

import 'cost.dart';

class CostData {
  String? code;
  String? name;
  List<Cost>? costs;

  CostData({this.code, this.name, this.costs});

  @override
  String toString() => 'CostData(code: $code, name: $name, costs: $costs)';

  factory CostData.fromJson(Map<String, dynamic> json) => CostData(
        code: json['code'] as String?,
        name: json['name'] as String?,
        costs: (json['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CostData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ costs.hashCode;
}

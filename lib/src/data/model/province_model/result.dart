import 'package:collection/collection.dart';

class Result {
  String? provinceId;
  String? province;

  Result({this.provinceId, this.province});

  @override
  String toString() {
    return 'Result(provinceId: $provinceId, province: $province)';
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'province': province,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => provinceId.hashCode ^ province.hashCode;
}

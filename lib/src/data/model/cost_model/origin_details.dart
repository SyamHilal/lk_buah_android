import 'package:collection/collection.dart';

class OriginDetails {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  OriginDetails({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  @override
  String toString() {
    return 'OriginDetails(cityId: $cityId, provinceId: $provinceId, province: $province, type: $type, cityName: $cityName, postalCode: $postalCode)';
  }

  factory OriginDetails.fromJson(Map<String, dynamic> json) => OriginDetails(
        cityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OriginDetails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      cityId.hashCode ^
      provinceId.hashCode ^
      province.hashCode ^
      type.hashCode ^
      cityName.hashCode ^
      postalCode.hashCode;
}

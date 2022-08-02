import 'package:collection/collection.dart';

import 'rajaongkir.dart';

class CityModel {
  Rajaongkir? rajaongkir;

  CityModel({this.rajaongkir});

  @override
  String toString() => 'CityModel(rajaongkir: $rajaongkir)';

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        rajaongkir: json['rajaongkir'] == null
            ? null
            : Rajaongkir.fromJson(json['rajaongkir'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'rajaongkir': rajaongkir?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CityModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => rajaongkir.hashCode;
}

import 'package:collection/collection.dart';

import 'rajaongkir.dart';

class ProvinceModel {
  Rajaongkir? rajaongkir;

  ProvinceModel({this.rajaongkir});

  @override
  String toString() => 'ProvinceModel(rajaongkir: $rajaongkir)';

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
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
    if (other is! ProvinceModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => rajaongkir.hashCode;
}

import 'package:collection/collection.dart';

import 'rajaongkir.dart';

class CostModel {
  Rajaongkir? rajaongkir;

  CostModel({this.rajaongkir});

  @override
  String toString() => 'CostModel(rajaongkir: $rajaongkir)';

  factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
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
    if (other is! CostModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => rajaongkir.hashCode;
}

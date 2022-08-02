import 'package:collection/collection.dart';

import 'query.dart';
import 'result.dart';
import 'status.dart';

class Rajaongkir {
  Query? query;
  Status? status;
  List<CityData>? results;

  Rajaongkir({this.query, this.status, this.results});

  @override
  String toString() {
    return 'Rajaongkir(query: $query, status: $status, results: $results)';
  }

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: json['query'] == null
            ? null
            : Query.fromJson(json['query'] as Map<String, dynamic>),
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => CityData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'query': query?.toJson(),
        'status': status?.toJson(),
        'results': results?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Rajaongkir) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => query.hashCode ^ status.hashCode ^ results.hashCode;
}

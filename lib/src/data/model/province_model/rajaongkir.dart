import 'package:collection/collection.dart';

import 'result.dart';
import 'status.dart';

class Rajaongkir {
  List<dynamic>? query;
  Status? status;
  List<Result>? results;

  Rajaongkir({this.query, this.status, this.results});

  @override
  String toString() {
    return 'Rajaongkir(query: $query, status: $status, results: $results)';
  }

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: json['query'] as List<dynamic>?,
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'query': query,
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

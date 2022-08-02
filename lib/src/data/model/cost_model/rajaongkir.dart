import 'package:collection/collection.dart';

import 'destination_details.dart';
import 'origin_details.dart';
import 'query.dart';
import 'result.dart';
import 'status.dart';

class Rajaongkir {
  Query? query;
  Status? status;
  OriginDetails? originDetails;
  DestinationDetails? destinationDetails;
  List<CostData>? results;

  Rajaongkir({
    this.query,
    this.status,
    this.originDetails,
    this.destinationDetails,
    this.results,
  });

  @override
  String toString() {
    return 'Rajaongkir(query: $query, status: $status, originDetails: $originDetails, destinationDetails: $destinationDetails, results: $results)';
  }

  factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: json['query'] == null
            ? null
            : Query.fromJson(json['query'] as Map<String, dynamic>),
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        originDetails: json['origin_details'] == null
            ? null
            : OriginDetails.fromJson(
                json['origin_details'] as Map<String, dynamic>),
        destinationDetails: json['destination_details'] == null
            ? null
            : DestinationDetails.fromJson(
                json['destination_details'] as Map<String, dynamic>),
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => CostData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'query': query?.toJson(),
        'status': status?.toJson(),
        'origin_details': originDetails?.toJson(),
        'destination_details': destinationDetails?.toJson(),
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
  int get hashCode =>
      query.hashCode ^
      status.hashCode ^
      originDetails.hashCode ^
      destinationDetails.hashCode ^
      results.hashCode;
}

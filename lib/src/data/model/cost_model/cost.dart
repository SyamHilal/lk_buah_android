import 'package:collection/collection.dart';

import 'cost.dart';

class Cost {
  String? service;
  String? description;
  dynamic cost;

  Cost({this.service, this.description, this.cost});

  @override
  String toString() {
    return 'Cost(service: $service, description: $description, cost: $cost)';
  }

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        service: json['service'] as String?,
        description: json['description'] as String?,
        cost: (json['cost'] as List<dynamic>?),
      );

  Map<String, dynamic> toJson() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Cost) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => service.hashCode ^ description.hashCode ^ cost.hashCode;
}

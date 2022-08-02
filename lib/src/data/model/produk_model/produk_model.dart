import 'package:collection/collection.dart';

import 'datum.dart';

class ProdukModel {
  bool? status;
  int? code;
  String? message;
  List<DataProduk>? data;

  ProdukModel({this.status, this.code, this.message, this.data});

  @override
  String toString() {
    return 'ProdukModel(status: $status, code: $code, message: $message, data: $data)';
  }

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
        status: json['status'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DataProduk.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProdukModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      status.hashCode ^ code.hashCode ^ message.hashCode ^ data.hashCode;
}

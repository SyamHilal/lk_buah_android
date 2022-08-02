import 'package:collection/collection.dart';

import 'datum.dart';

class TransaksiModel {
  bool? status;
  int? code;
  String? message;
  List<DataTransaksi>? data;

  TransaksiModel({this.status, this.code, this.message, this.data});

  @override
  String toString() {
    return 'TransaksiModel(status: $status, code: $code, message: $message, data: $data)';
  }

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
      status: json['status'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataTransaksi.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TransaksiModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      status.hashCode ^ code.hashCode ^ message.hashCode ^ data.hashCode;
}

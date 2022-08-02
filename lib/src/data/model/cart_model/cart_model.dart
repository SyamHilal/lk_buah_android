import 'package:collection/collection.dart';

import 'data_cart.dart';

class CartModel {
  bool? status;
  int? code;
  String? message;
  List<DataCart>? data;

  CartModel({this.status, this.code, this.message, this.data});

  @override
  String toString() {
    return 'CartModel(status: $status, code: $code, message: $message, data: $data)';
  }

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json['status'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DataCart.fromJson(e as Map<String, dynamic>))
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
    if (other is! CartModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      status.hashCode ^ code.hashCode ^ message.hashCode ^ data.hashCode;
}

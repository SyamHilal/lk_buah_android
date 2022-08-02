import 'package:collection/collection.dart';

import 'product.dart';

class DetailTransaksi {
  int? id;
  int? orderId;
  int? productId;
  int? qty;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic price;
  Product? product;

  DetailTransaksi({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.product,
  });

  @override
  String toString() {
    return 'DetailTransaksi(id: $id, orderId: $orderId, productId: $productId, qty: $qty, createdAt: $createdAt, updatedAt: $updatedAt, price: $price, product: $product)';
  }

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      productId: json['product_id'] as int?,
      qty: json['qty'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      price: json['price'] as dynamic,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'qty': qty,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'price': price,
        'product': product?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DetailTransaksi) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      orderId.hashCode ^
      productId.hashCode ^
      qty.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      price.hashCode ^
      product.hashCode;
}

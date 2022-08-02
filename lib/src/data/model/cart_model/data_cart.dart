import 'package:collection/collection.dart';

class DataCart {
  String? namaProduk;
  String? image;
  String? name;
  int? id;
  int? userId;
  int? productsId;
  int? qty;
  String? createdAt;
  String? updatedAt;
  int? price;
  int? weigth;

  DataCart(
      {this.namaProduk,
      this.image,
      this.name,
      this.id,
      this.userId,
      this.productsId,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.weigth});

  @override
  String toString() {
    return 'DataCart(namaProduk: $namaProduk, image: $image, name: $name, id: $id, userId: $userId, productsId: $productsId, qty: $qty, createdAt: $createdAt, updatedAt: $updatedAt, price: $price)';
  }

  factory DataCart.fromJson(Map<String, dynamic> json) => DataCart(
        namaProduk: json['nama_produk'] as String?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        productsId: json['products_id'] as int?,
        qty: json['qty'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        price: json['price'] as int?,
        weigth: json['weigth'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'nama_produk': namaProduk,
        'image': image,
        'name': name,
        'id': id,
        'user_id': userId,
        'products_id': productsId,
        'qty': qty,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'price': price,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DataCart) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      namaProduk.hashCode ^
      image.hashCode ^
      name.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      productsId.hashCode ^
      qty.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      weigth.hashCode ^
      price.hashCode;
}

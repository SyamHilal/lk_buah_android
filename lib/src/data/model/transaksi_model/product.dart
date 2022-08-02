import 'package:collection/collection.dart';

class Product {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  int? weigth;
  int? categoriesId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? stok;
  String? unit;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.weigth,
    this.categoriesId,
    this.createdAt,
    this.updatedAt,
    this.stok,
    this.unit,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, image: $image, price: $price, weigth: $weigth, categoriesId: $categoriesId, createdAt: $createdAt, updatedAt: $updatedAt, stok: $stok, unit: $unit)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        price: json['price'] as int?,
        weigth: json['weigth'] as int?,
        categoriesId: json['categories_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        stok: json['stok'] as int?,
        unit: json['unit'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'weigth': weigth,
        'categories_id': categoriesId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'stok': stok,
        'unit': unit,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Product) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      price.hashCode ^
      weigth.hashCode ^
      categoriesId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      stok.hashCode ^
      unit.hashCode;
}

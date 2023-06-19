import 'dart:convert';

import 'package:fake_store_shop_app/models/product.dart';
import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Product product;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final double totalAmount;
  Cart({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalAmount,
  });

  Cart copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? totalAmount,
  }) {
    return Cart(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product': product.toMap()});
    result.addAll({'quantity': quantity});
    result.addAll({'totalAmount': totalAmount});

    return result;
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? '',
      product: Product.fromMap(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, product: $product, quantity: $quantity, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.id == id &&
        other.product == product &&
        other.quantity == quantity &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product.hashCode ^
        quantity.hashCode ^
        totalAmount.hashCode;
  }
}

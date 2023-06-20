import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Map<String, dynamic> product;
  @HiveField(2)
  int? quantity;
  Cart({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  Cart copyWith({
    String? id,
    Map<String, dynamic>? product,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product': product});
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }

    return result;
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? '',
      product: Map<String, dynamic>.from(map['product']),
      quantity: map['quantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, product: $product, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.id == id &&
        mapEquals(other.product, product) &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode ^ quantity.hashCode;
}

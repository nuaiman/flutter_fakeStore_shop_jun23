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
  Cart({
    required this.id,
    required this.product,
  });

  Cart copyWith({
    String? id,
    Map<String, dynamic>? product,
  }) {
    return Cart(
      id: id ?? this.id,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product': product});

    return result;
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? '',
      product: Map<String, dynamic>.from(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(id: $id, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && other.id == id && mapEquals(other.product, product);
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode;
}

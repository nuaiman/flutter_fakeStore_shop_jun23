import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../models/cart.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Cart>('cart').listenable(),
        builder: (context, box, child) => ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final cartItem = box.getAt(index);
            return ListTile(
              title: Text(cartItem!.product['title']),
              subtitle: Text(cartItem.quantity.toString()),
            );
          },
        ),
      ),
    );
  }
}

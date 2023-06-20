import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/cart.dart';
import '../../cart/controller/cart_controller.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfCartItems = ref.watch(cartControllerProvider);
    final isItemInCart = listOfCartItems
        .contains(Cart(id: item.id.toString(), product: item.toMap()));
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.indigoAccent,
        child: TextButton.icon(
          onPressed: isItemInCart
              ? () {
                  ref
                      .read(cartControllerProvider.notifier)
                      .removeFromCart(item);
                }
              : () {
                  ref.read(cartControllerProvider.notifier).addToCart(item);
                },
          icon: Icon(
            isItemInCart ? Icons.check : Icons.add_shopping_cart_sharp,
            color: Colors.white,
          ),
          label: Text(
            isItemInCart ? 'Already In Cart' : 'Add to Cart',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
                child: Image.network(item.image),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('◉ ${item.category}'),
                  Text('\$ ${item.price}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

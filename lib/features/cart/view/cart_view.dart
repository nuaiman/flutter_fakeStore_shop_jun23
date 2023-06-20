import 'package:fake_store_shop_app/features/products/view/product_details_view.dart';
import 'package:fake_store_shop_app/models/product.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
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
            final product = Product.fromMap(cartItem!.product);
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailsView(item: product),
                  ));
                },
                leading: SizedBox(
                  height: 100,
                  child: FastCachedImage(
                    url: product.image,
                    errorBuilder: (context, exception, stacktrace) {
                      return const Center(
                        child: Icon(Icons.image),
                      );
                    },
                  ),
                ),
                title: Text(cartItem.product['title']),
              ),
            );
          },
        ),
      ),
    );
  }
}

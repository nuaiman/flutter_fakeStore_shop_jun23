import 'package:fake_store_shop_app/features/cart/controller/cart_controller.dart';
import 'package:fake_store_shop_app/features/products/view/product_details_view.dart';
import 'package:fake_store_shop_app/models/cart.dart';
import 'package:fake_store_shop_app/models/product.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfCartItems = ref.watch(cartControllerProvider);
    final isItemInCart = listOfCartItems
        .contains(Cart(id: item.id.toString(), product: item.toMap()));
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(item: item),
          ),
        );
      },
      child: Stack(
        children: [
          Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: 150,
                  color: Colors.white,
                  child: FastCachedImage(
                    url: item.image,
                    errorBuilder: (context, exception, stacktrace) {
                      return const Center(
                        child: Icon(Icons.image),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text('◉ ${item.category}'),
                      Text('\$ ${item.price}'),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: isItemInCart
                      ? () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .removeFromCart(item);
                        }
                      : () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .addToCart(item);
                        },
                  icon: Icon(isItemInCart
                      ? Icons.check
                      : Icons.add_shopping_cart_sharp),
                  label: Text(isItemInCart ? 'Already In Cart' : 'Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

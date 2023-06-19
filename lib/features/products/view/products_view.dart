import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/products_controller.dart';
import '../widgets/product_card.dart';

class ProductsView extends ConsumerStatefulWidget {
  const ProductsView({super.key});

  @override
  ConsumerState<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  late Future<List<dynamic>> _getProductsFuture;

  @override
  void initState() {
    _getProductsFuture =
        ref.read(productsControllerProvider.notifier).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProductsFuture,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Products'),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                  body: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        ProductCard(item: snapshot.data![index]),
                  ),
                ),
    );
  }
}

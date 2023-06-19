import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_store_shop_app/features/cart/view/cart_view.dart';
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
  late ConnectivityResult _connectivity;

  Future<void> checkConnectivity() async {
    _connectivity = await (Connectivity().checkConnectivity());

    if (_connectivity == ConnectivityResult.mobile) {
      _getProductsFuture =
          ref.read(productsControllerProvider.notifier).getAllProducts();
    } else if (_connectivity == ConnectivityResult.wifi) {
      _getProductsFuture =
          ref.read(productsControllerProvider.notifier).getAllProducts();
    } else if (_connectivity == ConnectivityResult.none) {
      _getProductsFuture =
          ref.read(productsControllerProvider.notifier).getProductsFromPrefs();
    }
  }

  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkConnectivity(),
      builder: (context, snapshotConnectivity) =>
          snapshotConnectivity.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: _getProductsFuture,
                  builder: (context, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Scaffold(
                          appBar: AppBar(
                            title: const Text('Products'),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const CartView(),
                                  ));
                                },
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
                ),
    );
  }
}

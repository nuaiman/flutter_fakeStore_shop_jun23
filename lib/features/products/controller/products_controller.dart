import 'dart:convert';

import 'package:fake_store_shop_app/apis/products_api.dart';
import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsControllerNotifier extends StateNotifier<bool> {
  final ProductsApi _productsApi;
  ProductsControllerNotifier({required ProductsApi productsApi})
      : _productsApi = productsApi,
        super(false);

  Future<List<dynamic>> getAllProducts() async {
    final response = await _productsApi.getAllProducts();
    final decodedData = jsonDecode(response.body);
    final listOfProducts =
        decodedData.map((product) => Product.fromMap(product)).toList();
    print(listOfProducts);
    return listOfProducts;
  }
}
// -----------------------------------------------------------------------------

final productsControllerProvider = StateNotifierProvider((ref) {
  final productsApi = ref.watch(productsApiProvider);
  return ProductsControllerNotifier(productsApi: productsApi);
});

final productsFutureProvider = FutureProvider((ref) async {
  final productsController = ref.watch(productsControllerProvider.notifier);
  return productsController.getAllProducts();
});

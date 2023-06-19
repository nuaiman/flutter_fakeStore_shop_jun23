import 'dart:convert';

import 'package:fake_store_shop_app/apis/products_api.dart';
import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsControllerNotifier extends StateNotifier<bool> {
  final ProductsApi _productsApi;
  ProductsControllerNotifier({required ProductsApi productsApi})
      : _productsApi = productsApi,
        super(false);

  Future<List<dynamic>> getAllProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _productsApi.getAllProducts();
    final decodedData = jsonDecode(response.body);
    if (decodedData != null) {
      prefs.setString('products', json.encode(decodedData));
    }
    final listOfProducts =
        decodedData.map((product) => Product.fromMap(product)).toList();
    return listOfProducts;
  }

  Future<List<dynamic>> getProductsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final prefsResult = prefs.getString('products');
    final result = json.decode(prefsResult!);
    final listOfProducts =
        result.map((product) => Product.fromMap(product)).toList();
    return listOfProducts;
  }
}
// -----------------------------------------------------------------------------

final productsControllerProvider = StateNotifierProvider((ref) {
  final productsApi = ref.watch(productsApiProvider);
  return ProductsControllerNotifier(productsApi: productsApi);
});

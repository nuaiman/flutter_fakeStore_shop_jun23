import 'package:fake_store_shop_app/constants/fake_store_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

abstract class IProductsApi {
  Future<http.Response> getAllProducts();
}
// -----------------------------------------------------------------------------

class ProductsApi implements IProductsApi {
  @override
  Future<http.Response> getAllProducts() async {
    try {
      final uri = Uri.parse('${FakeStoreConstants.storeUrl}products');
      final response = await http.get(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
// -----------------------------------------------------------------------------

final productsApiProvider = Provider((ref) {
  return ProductsApi();
});

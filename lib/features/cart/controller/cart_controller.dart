import 'package:fake_store_shop_app/models/cart.dart';
import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class CartControllerNotifier extends StateNotifier<List<Cart>> {
  CartControllerNotifier() : super([]);

  void getItemsFromHive() {
    var mw = Hive.box<Cart>('cart').values;
    List<Cart> newList = [];
    for (var element in mw) {
      newList.add(element);
    }
    state = newList;
  }

  void addToCart(Product product) {
    Cart newCartItem = Cart(
      id: product.id.toString(),
      product: product.toMap(),
    );

    // Hive.box<Cart>('cart').add(newCartItem);
    Hive.box<Cart>('cart').put(newCartItem.id, newCartItem);

    state = [newCartItem, ...state];
  }

  List<Cart> removeFromCart(Product product) {
    List<Cart> newList = [...state];

    newList.removeWhere((element) => element.id == product.id.toString());

    state = [...newList];

    Hive.box<Cart>('cart').delete(product.id.toString());

    return state;
  }
}
// -----------------------------------------------------------------------------

final cartControllerProvider =
    StateNotifierProvider<CartControllerNotifier, List<Cart>>((ref) {
  return CartControllerNotifier();
});

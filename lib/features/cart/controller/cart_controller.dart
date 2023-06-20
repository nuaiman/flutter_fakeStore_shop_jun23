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

    Hive.box<Cart>('cart').add(newCartItem);

    state = [newCartItem, ...state];
  }

  // void removeFromCart(Product product) {
  //   List<Cart> newList = state;
  //   newList.removeWhere((element) => element.id == product.id.toString());
  //   Hive.box<Cart>('cart').add(Cart(
  //     id: product.id.toString(),
  //     product: product.toMap(),
  //   ));
  //   state = [...newList];
  // }
}
// -----------------------------------------------------------------------------

final cartControllerProvider =
    StateNotifierProvider<CartControllerNotifier, List<Cart>>((ref) {
  return CartControllerNotifier();
});

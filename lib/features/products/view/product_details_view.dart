import 'package:fake_store_shop_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.indigoAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.add_shopping_cart_sharp,
                color: Colors.white,
              ),
            ),
          ],
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

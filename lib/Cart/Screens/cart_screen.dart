import 'package:ecommerce_app/Products/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.read(cartListProvider);
    final productController = ref.watch(productControllerProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => productController.deleteProduct(cartItems[index]),
            title: Text(
              cartItems[index].title.toString(),
            ),
            trailing: Text(
              cartItems[index].quantity.toString(),
            ),
          );
        },
      ),
    );
  }
}

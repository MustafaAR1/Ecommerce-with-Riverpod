import 'package:ecommerce_app/Cart/Screens/cart_screen.dart';
import 'package:ecommerce_app/Products/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productRepo = ref.watch(fetchProductsProvider);
    final productController = ref.watch(productControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(productController.cartList.length.toString()),
        onPressed: () {
          productController.incrementCounter();
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                )),
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: productRepo.when(
        loading: () {
          return const Center(
            child: Text("Loading"),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                productController.addTocart(data[index]);
              },
              child: ListTile(
                trailing: Text(
                  data[index].price.toString(),
                ),
                title: Text(
                  data[index].title.toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

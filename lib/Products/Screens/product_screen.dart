import 'package:ecommerce_app/Cart/Screens/cart_screen.dart';
import 'package:ecommerce_app/Data/Remote/Models/Products/product_model.dart';
import 'package:ecommerce_app/Products/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  int page = 1;

  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final productController = ref.watch(productControllerProvider);
    fetchNewPage();
    _pagingController.addPageRequestListener((page) {
      productController.fetchProducts;
    });
    super.didChangeDependencies();
  }

  Future<void> fetchNewPage() async {
    final productController = ref.watch(productControllerProvider);
    try {
      final newItems = await productController.fetchProducts;
      _pagingController.appendLastPage(newItems);
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final productRepo = ref.watch(fetchProductsProvider);
    final productController = ref.watch(productControllerProvider);

    return Scaffold(
      floatingActionButton: floatingActionBtn(productController),
      appBar: appbar(context),
      body: scaffoldBody(
        productRepo,
        productController,
      ),
    );
  }

  Widget? scaffoldBody(AsyncValue<List<ProductModel>> productRepo,
      ProductController productController) {
    return productRepo.when(
      loading: () {
        return const Center(
          child: Text("Loading"),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      data: (data) {
        return ProductListView(
          productController: productController,
          products: data,
          pagingController: _pagingController,
        );
      },
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
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
    );
  }

  FloatingActionButton floatingActionBtn(ProductController productController) {
    int productLength = productController.cartList.length;
    return FloatingActionButton(
      child: Text(productLength.toString()),
      onPressed: () {
        productController.incrementCounter();
      },
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  final ProductController productController;
  final PagingController<int, ProductModel> pagingController;
  const ProductListView({
    required this.products,
    required this.productController,
    Key? key,
    required this.pagingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ProductModel>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<ProductModel>(
            itemBuilder: (context, item, index) {
          print(pagingController.itemList![index].title);
          return Column(
            children: [
              InkWell(
                onTap: () => productController.addTocart(products[index]),
                child: ListTile(
                  trailing: Text(item.price.toString()),
                  title: Text(
                    item.title.toString(),
                  ),
                ),
              ),
              //    card(item[0], item[1]),
              if (index == pagingController.itemList!.length - 1)
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("No More Data"),
                ),
            ],
          );
        }));

    //  ListView.builder(
    //   itemCount: products.length,
    //   itemBuilder: (context, index) =>
    // InkWell(
    //     onTap: () {
    //       productController.addTocart(products[index]);
    //     },
    //     child: ListTile(
    //       trailing: Text(
    //         products[index].price.toString(),
    //       ),
    //       title: Text(
    //         products[index].title.toString(),
    //       ),
    //     ),
    //   ),
    // );
  }
}

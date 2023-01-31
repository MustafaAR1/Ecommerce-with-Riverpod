import 'package:ecommerce_app/Data/Remote/Models/Products/cart_model.dart';
import 'package:ecommerce_app/Products/Repositories/product_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Data/Remote/Models/Products/product_model.dart';

final productControllerProvider = ChangeNotifierProvider<ProductController>(
  (ref) {
    final productRepository =
        ref.read<ProductRepository>(productRepositoryProvider);
    return ProductController(productRepository);
  },
);

final fetchProductsProvider = FutureProvider<List<ProductModel>>(
  (ref) {
    final productRepo = ref.read(productControllerProvider);
    return productRepo.fetchProducts;
  },
);

final cartListProvider = Provider<List<ProductModel>>(
  (ref) {
    final cartList = ref.read(productControllerProvider);
    return cartList._cartList;
  },
);

class ProductController extends ChangeNotifier {
  final ProductRepository _productRepository;

  final List<ProductModel> _cartList = [];

  int _counter = 0;

  int get counter => _counter;

  List<ProductModel> get cartList => _cartList;

  Future<List<ProductModel>> get fetchProducts =>
      _productRepository.fetchProducts();

  ProductRepository get productRepository => _productRepository;

  ProductController(this._productRepository);

  void incrementCounter() {
    _counter = _counter + 1;
    notifyListeners();
  }

  void addTocart(ProductModel product) {
    //* Filter the product from the cart list
    var filterInstance = filterList(product);
    //* Add the product to the cart list
    addSingleProductToCart(filterInstance, product);
    //* Increment the quantity of the product in the cart list
    incrementProductQuantity(filterInstance);
  }

  void addSingleProductToCart(
      List<ProductModel> filterInstance, ProductModel product) {
    //* Check if the product is already in the cart list
    if (filterInstance.isEmpty) {
      //* Add the product to the cart list
      return _cartList.add(product);
    }
    notifyListeners();
  }

  void incrementProductQuantity(List<ProductModel> filteredList) {
    //* //Increment the quantity of the product in the cart list
    filteredList.map((e) {
      return e.quantity = e.quantity! + 1;
    }).toList();
    notifyListeners();
  }

  List<ProductModel> filterList(ProductModel product) {
    List<ProductModel> filteredList =
        _cartList.where((element) => element.id == product.id).toList();
    return filteredList;
  }

  // notifyListeners();

  void deleteProduct(ProductModel product) {
    _cartList.remove(product);
    notifyListeners();
  }
}

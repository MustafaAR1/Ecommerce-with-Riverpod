import 'package:ecommerce_app/Data/Remote/Models/Products/product_model.dart';

class CartModel {
  final ProductModel productModel;
  int quantity = 1;
  CartModel({
    required this.productModel,
  });
}

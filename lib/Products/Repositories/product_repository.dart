import 'package:ecommerce_app/Controllers/Providers/providers.dart';
import 'package:ecommerce_app/Data/Remote/Models/Products/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref);
});

class ProductRepository {
  final ProviderRef ref;

  ProductRepository(this.ref);

  Future<List<ProductModel>> fetchProducts() async {
    final dioClient = ref.read(dioClientProvider);
    try {
      final response = await dioClient.sendRequest.get('/products');
      return response.data.map<ProductModel>((e) {
        return ProductModel.fromJson(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<ProductModel>> get fetchProducts =>
  //     ref.read(apiProvider).fetchProducts();

}

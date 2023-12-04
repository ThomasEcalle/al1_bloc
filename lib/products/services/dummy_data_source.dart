import 'package:al1_bloc/products/models/product.dart';
import 'package:al1_bloc/products/services/products_data_source.dart';

class DummyDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(2, (index) {
      return Product(name: 'Product $index', price: index);
    });
  }
}

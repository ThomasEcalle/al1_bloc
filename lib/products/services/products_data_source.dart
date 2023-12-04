import 'package:al1_bloc/products/models/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getAllProducts();
}

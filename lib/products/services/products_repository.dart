import 'package:al1_bloc/products/models/product.dart';
import 'package:al1_bloc/products/services/products_data_source.dart';

class ProductsRepository {
  final ProductsDataSource remoteDataSource;
  final ProductsDataSource localDataSource;

  ProductsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Product>> getAllProducts() async {
    try {
      final products = remoteDataSource.getAllProducts();
      //localDataSource.saveProducts(products);
      return products;
    } catch (error) {
      return localDataSource.getAllProducts();
    }
  }
}

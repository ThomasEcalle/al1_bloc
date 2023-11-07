import 'package:al1_bloc/products/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState()) {
    on<GetProducts>(_onGetProducts);
  }

  void _onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final products = await _getAllProducts();
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        error: Exception(),
      ));
    }
  }

  Future<List<Product>> _getAllProducts() async {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://dummyjson.com'),
    );

    final response = await dio.get('/products');
    final jsonList = response.data['products'] as List;
    return jsonList.map((jsonElement) => Product.fromJson(jsonElement)).toList();
  }
}

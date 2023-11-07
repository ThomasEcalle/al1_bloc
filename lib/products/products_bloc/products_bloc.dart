import 'package:al1_bloc/products/models/product.dart';
import 'package:bloc/bloc.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    return [
      Product(name: 'iPhone 15', price: 10),
      Product(name: 'Pixel 7', price: 30),
    ];
  }
}

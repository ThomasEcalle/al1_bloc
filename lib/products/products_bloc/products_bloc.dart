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
    emit(ProductsState(status: ProductsStatus.loading));

    await Future.delayed(const Duration(seconds: 2));
    final newState = ProductsState(
      status: ProductsStatus.success,
      products: [
        Product(name: 'iPhone 15', price: 10),
        Product(name: 'Pixel 7', price: 30),
      ],
    );

    emit(newState);
  }
}

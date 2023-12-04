import 'package:al1_bloc/products/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.addingProduct));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final product = event.product;
      if (product.name == 'iPhone 9') {
        throw Exception();
      }

      emit(state.copyWith(
        status: CartStatus.addedProductWithSuccess,
        products: [
          ...state.products,
          product,
        ],
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: CartStatus.errorAddingProduct,
          exception: Exception(),
        ),
      );
    }
  }
}

part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  addingProduct,
  addedProductWithSuccess,
  errorAddingProduct,
}

class CartState {
  final CartStatus status;
  final List<Product> products;
  final Exception? exception;

  const CartState({
    this.status = CartStatus.initial,
    this.products = const [],
    this.exception,
  });

  CartState copyWith({
    CartStatus? status,
    List<Product>? products,
    Exception? exception,
  }) {
    return CartState(
      status: status ?? this.status,
      products: products ?? this.products,
      exception: exception,
    );
  }
}

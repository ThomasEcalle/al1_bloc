part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddProduct extends CartEvent {
  final Product product;

  AddProduct({required this.product});
}

part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {
  const ProductsEvent();
}

class GetProducts extends ProductsEvent {}

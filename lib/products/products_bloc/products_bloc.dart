import 'package:al1_bloc/products/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<GetProducts>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      final products = List.generate(50, (index) {
        return Product(
          name: 'Produit $index',
          description: 'Description $index',
          price: index.toDouble(),
        );
      });


    });
  }
}

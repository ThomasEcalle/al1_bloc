import 'package:al1_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al1_bloc/products/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previousState, nextState) {
        final previous = previousState.products.where((element) => element.name == product.name).length;
        final next = nextState.products.where((element) => element.name == product.name).length;
        return previous != next;
      },
      builder: (context, state) {
        print('Building ${product.name}');
        final occurrences = state.products.where((element) => element.name == product.name).length;
        return ListTile(
          title: Text(product.name ?? ''),
          subtitle: Text('${product.price}'),
          trailing: Text('($occurrences)'),
          onTap: onTap,
        );
      },
    );
  }
}

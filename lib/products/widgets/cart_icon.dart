import 'package:al1_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Row(
            children: [
              const Icon(
                Icons.shopping_cart,
              ),
              const SizedBox(
                width: 5,
              ),
              Text('(${state.products.length})')
            ],
          );
        },
      ),
    );
  }
}

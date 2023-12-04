import 'package:al1_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al1_bloc/products/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product';

  static void navigateTo(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(routeName, arguments: product);
  }

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: _onCartBlocListener,
      builder: (context, state) {
        final isLoading = state.status == CartStatus.addingProduct;
        return Scaffold(
          appBar: AppBar(
            title: Text('${product.name}'),
          ),
          body: Column(
            children: [
              Text('${product.price}'),
            ],
          ),
          floatingActionButton: _buildFloatingButton(context, isLoading),
        );
      },
    );
  }

  Widget _buildFloatingButton(BuildContext context, bool loading) {
    if (loading) {
      return Container(
        height: 30,
        width: 30,
        color: Colors.red,
      );
    }

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _onAddToCart(context),
    );
  }

  void _onCartBlocListener(BuildContext context, CartState state) {
    switch (state.status) {
      case CartStatus.errorAddingProduct:
        _showSnackBar(context);
      default:
        break;
    }
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('coucou')));
  }

  void _onAddToCart(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);
    final cartBloc = context.read<CartBloc>();
    cartBloc.add(AddProduct(product: product));
  }
}

import 'package:al1_bloc/products/cart_screen/cart_screen.dart';
import 'package:al1_bloc/products/models/product.dart';
import 'package:al1_bloc/products/product_detail_screen/product_detail_screen.dart';
import 'package:al1_bloc/products/widgets/cart_icon.dart';
import 'package:al1_bloc/products/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_bloc/products_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        actions: [
          CartIcon(
            onTap: () => _onCartIconTap(context),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.initial:
              return const SizedBox();
            case ProductsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProductsStatus.error:
              return const Center(
                child: Text('Oups, on a une erreur'),
              );
            case ProductsStatus.success:
              final products = state.products;
              return RefreshIndicator(
                onRefresh: () async => _refreshList(),
                child: ListView.builder(
                  itemCount: products.length + 1,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItem(
                      product: product,
                      onTap: () => _onProductTap(context, product),
                    );
                  },
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _refreshList(),
      ),
    );
  }

  void _onProductTap(BuildContext context, Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }

  void _onCartIconTap(BuildContext context) {
    CartScreen.navigateTo(context);
  }
}

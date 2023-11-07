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
        title: Text('Produits'),
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
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                  );
                },
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
}

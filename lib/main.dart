import 'package:al1_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al1_bloc/products/cart_screen/cart_screen.dart';
import 'package:al1_bloc/products/models/product.dart';
import 'package:al1_bloc/products/product_detail_screen/product_detail_screen.dart';
import 'package:al1_bloc/products/products_bloc/products_bloc.dart';
import 'package:al1_bloc/products/products_screen.dart';
import 'package:al1_bloc/products/services/api_data_source.dart';
import 'package:al1_bloc/products/services/dummy_data_source.dart';
import 'package:al1_bloc/products/services/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductsRepository(
        remoteDataSource: DummyDataSource(),
        localDataSource: ApiDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc(
              productsRepository: context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/': (_) => const ProductsScreen(),
            CartScreen.routeName: (_) => const CartScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();

            switch (settings.name) {
              case ProductDetailScreen.routeName:
                final argument = settings.arguments;
                if (argument is Product) {
                  content = ProductDetailScreen(product: argument);
                }
            }

            return MaterialPageRoute(builder: (context) => content);
          },
        ),
      ),
    );
  }
}

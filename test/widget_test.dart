// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:al1_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al1_bloc/products/models/product.dart';
import 'package:al1_bloc/products/products_bloc/products_bloc.dart';
import 'package:al1_bloc/products/products_screen.dart';
import 'package:al1_bloc/products/services/products_data_source.dart';
import 'package:al1_bloc/products/services/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class SuccessFakeDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(2, (index) {
      return Product(name: 'Product $index', price: index);
    });
  }
}

class EmptyDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}

class ErrorDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
  }
}

Widget _buildProductsScreen(ProductsDataSource productsDataSource) {
  return RepositoryProvider(
    create: (context) => ProductsRepository(
      remoteDataSource: productsDataSource,
      localDataSource: productsDataSource,
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
      child: const MaterialApp(
        home: ProductsScreen(),
      ),
    ),
  );
}

void main() {
  group('ProductsScreen', () {
    testWidgets('ProductsScreen should display the right title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(SuccessFakeDataSource()));
      await tester.pumpAndSettle();
      expect(find.text('Produits'), findsOneWidget);
    });

    testWidgets('ProductsScreen should load when getting products', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(SuccessFakeDataSource()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('ProductsScreen should display the products when succeed', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(SuccessFakeDataSource()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Product 0'), findsOneWidget);
      expect(find.text('Product 1'), findsOneWidget);
    });

    testWidgets('ProductsScreen should display a specific message when empty results', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(EmptyDataSource()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Aucun produit'), findsOneWidget);
    });

    testWidgets('ProductsScreen should display an error when getting one from api', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(ErrorDataSource()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Oups, on a une erreur'), findsOneWidget);
    });
  });
}

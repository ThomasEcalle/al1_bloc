import 'package:al1_bloc/products/products_bloc/products_bloc.dart';
import 'package:al1_bloc/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(),
        )
      ],
      child: const MaterialApp(
        home: ProductsScreen(),
      ),
    );
  }
}

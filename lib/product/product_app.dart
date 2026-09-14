import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gravixor_store.dart';
import 'screens.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GravixorStore()),
      ],
      child: MaterialApp(
        title: 'Gravixor',
        debugShowCheckedModeBanner: false,
        home: const GravixorHome(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/inclinometer_screen.dart';
import 'theme/gravixor_theme.dart';

class GravixorApp extends StatelessWidget {
  const GravixorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gravixor Inclinometer',
      debugShowCheckedModeBanner: false,
      theme: GravixorTheme.themeData,
      home: const InclinometerScreen(),
    );
  }
}

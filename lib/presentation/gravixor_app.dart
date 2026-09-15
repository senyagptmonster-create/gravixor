import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/calibration_repository.dart';
import 'gravixor_palette.dart';
import 'pages/bubble_level_page.dart';
import 'pages/inclinometer_page.dart';
import 'pages/calibration_history_page.dart';
import 'pages/sensor_specs_page.dart';

class GravixorApp extends StatelessWidget {
  const GravixorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalibrationRepository(),
      child: MaterialApp(
        title: 'Gravixor Gyro Level',
        debugShowCheckedModeBanner: false,
        theme: GravixorPalette.theme,
        home: const _GravixorShell(),
      ),
    );
  }
}

class _GravixorShell extends StatefulWidget {
  const _GravixorShell();

  @override
  State<_GravixorShell> createState() => _GravixorShellState();
}

class _GravixorShellState extends State<_GravixorShell> {
  int _idx = 0;

  final List<Widget> _views = const [
    BubbleLevelPage(),
    InclinometerPage(),
    CalibrationHistoryPage(),
    SensorSpecsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _idx, children: _views),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.radio_button_checked), label: 'Bullseye'),
          NavigationDestination(icon: Icon(Icons.linear_scale), label: 'Incline'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Offsets'),
          NavigationDestination(icon: Icon(Icons.memory), label: 'Sensor'),
        ],
      ),
    );
  }
}

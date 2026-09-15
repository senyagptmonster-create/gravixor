import 'package:flutter/material.dart';
import '../gravixor_palette.dart';

class SensorSpecsPage extends StatelessWidget {
  const SensorSpecsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inclinometer Hardware')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: GravixorPalette.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: GravixorPalette.edge),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MEMS Gyroscope Architecture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  'Uses micro-electro-mechanical tri-axis angular rate sensors and gravity vector telemetry to resolve pitch and roll deviations to 0.1 degree accuracy.',
                  style: TextStyle(fontSize: 13, color: GravixorPalette.inkMuted, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

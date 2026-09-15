import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/calibration_repository.dart';
import '../gravixor_palette.dart';

class CalibrationHistoryPage extends StatelessWidget {
  const CalibrationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<CalibrationRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('Calibration Registry')),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Zero Offsets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pitch Offset (X)', style: TextStyle(color: GravixorPalette.inkMuted)),
                    Text('${repo.pitchOffset.toStringAsFixed(2)}°', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Roll Offset (Y)', style: TextStyle(color: GravixorPalette.inkMuted)),
                    Text('${repo.rollOffset.toStringAsFixed(2)}°', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

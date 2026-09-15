import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/calibration_repository.dart';
import '../gravixor_palette.dart';

class InclinometerPage extends StatelessWidget {
  const InclinometerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<CalibrationRepository>();
    final reading = repo.currentReading;

    return Scaffold(
      appBar: AppBar(title: const Text('Dual-Axis Inclinometer')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: GravixorPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GravixorPalette.edge),
              ),
              child: Column(
                children: [
                  _axisGauge('Pitch (X Longitudinal)', reading.pitchDeg),
                  const Divider(color: GravixorPalette.edge, height: 32),
                  _axisGauge('Roll (Y Transverse)', reading.rollDeg),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: GravixorPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GravixorPalette.edge),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () => repo.updateSimulation(-1.5, 0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () => repo.updateSimulation(1.5, 0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => repo.updateSimulation(0, -1.5),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => repo.updateSimulation(0, 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _axisGauge(String label, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('${val.toStringAsFixed(1)}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: GravixorPalette.accent)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: ((val + 45.0) / 90.0).clamp(0.0, 1.0),
          color: GravixorPalette.accent,
          backgroundColor: GravixorPalette.edge,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}

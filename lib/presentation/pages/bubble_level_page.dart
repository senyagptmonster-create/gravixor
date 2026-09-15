import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/calibration_repository.dart';
import '../gravixor_palette.dart';

class BubbleLevelPage extends StatelessWidget {
  const BubbleLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<CalibrationRepository>();
    final reading = repo.currentReading;

    return Scaffold(
      appBar: AppBar(title: const Text('Circular Bullseye Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: GravixorPalette.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: reading.isLevel ? Colors.greenAccent : GravixorPalette.accent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (reading.isLevel ? Colors.greenAccent : GravixorPalette.accent).withAlpha(40),
                    blurRadius: 28,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: GravixorPalette.edge, width: 2),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: GravixorPalette.edge, width: 1.5),
                    ),
                  ),
                  // Bubble
                  Transform.translate(
                    offset: Offset(
                      (reading.rollDeg * 4).clamp(-100.0, 100.0),
                      (reading.pitchDeg * 4).clamp(-100.0, 100.0),
                    ),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: reading.isLevel ? Colors.greenAccent : GravixorPalette.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '${reading.compositeAngle.toStringAsFixed(1)}°',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: reading.isLevel ? Colors.greenAccent : GravixorPalette.ink,
              ),
            ),
            Text(
              reading.isLevel ? 'SURFACE ALIGNED (0°)' : 'TILT DETECTED',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: reading.isLevel ? Colors.greenAccent : GravixorPalette.accent2,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GravixorPalette.surface,
                    foregroundColor: GravixorPalette.ink,
                    side: const BorderSide(color: GravixorPalette.edge),
                  ),
                  icon: const Icon(Icons.exposure_zero),
                  label: const Text('Calibrate Zero'),
                  onPressed: () => repo.calibrateCurrent(),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GravixorPalette.edge,
                    foregroundColor: GravixorPalette.inkMuted,
                  ),
                  onPressed: () => repo.resetCalibration(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

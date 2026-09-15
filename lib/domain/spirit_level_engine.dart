import 'dart:math';

class LevelReading {
  final double pitchDeg; // X-axis tilt
  final double rollDeg;  // Y-axis tilt
  final bool isLevel;

  LevelReading({
    required this.pitchDeg,
    required this.rollDeg,
  }) : isLevel = pitchDeg.abs() < 0.8 && rollDeg.abs() < 0.8;

  double get compositeAngle => sqrt(pitchDeg * pitchDeg + rollDeg * rollDeg);
}

class SpiritLevelEngine {
  static LevelReading applyCalibration(double rawPitch, double rawRoll, double offsetPitch, double offsetRoll) {
    return LevelReading(
      pitchDeg: rawPitch - offsetPitch,
      rollDeg: rawRoll - offsetRoll,
    );
  }
}

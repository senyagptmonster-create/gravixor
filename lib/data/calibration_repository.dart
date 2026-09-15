import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/spirit_level_engine.dart';

class CalibrationRepository extends ChangeNotifier {
  static const _pitchKey = 'gravixor_pitch_offset_v2';
  static const _rollKey = 'gravixor_roll_offset_v2';

  double _pitchOffset = 0.0;
  double _rollOffset = 0.0;

  double _currentRawPitch = 0.4;
  double _currentRawRoll = -0.2;

  double get pitchOffset => _pitchOffset;
  double get rollOffset => _rollOffset;

  LevelReading get currentReading => SpiritLevelEngine.applyCalibration(
    _currentRawPitch,
    _currentRawRoll,
    _pitchOffset,
    _rollOffset,
  );

  CalibrationRepository() {
    _loadCalibration();
  }

  Future<void> _loadCalibration() async {
    final prefs = await SharedPreferences.getInstance();
    _pitchOffset = prefs.getDouble(_pitchKey) ?? 0.0;
    _rollOffset = prefs.getDouble(_rollKey) ?? 0.0;
    notifyListeners();
  }

  void updateSimulation(double dp, double dr) {
    _currentRawPitch = (_currentRawPitch + dp).clamp(-45.0, 45.0);
    _currentRawRoll = (_currentRawRoll + dr).clamp(-45.0, 45.0);
    notifyListeners();
  }

  void calibrateCurrent() async {
    _pitchOffset = _currentRawPitch;
    _rollOffset = _currentRawRoll;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_pitchKey, _pitchOffset);
    await prefs.setDouble(_rollKey, _rollOffset);
    notifyListeners();
  }

  void resetCalibration() async {
    _pitchOffset = 0.0;
    _rollOffset = 0.0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pitchKey);
    await prefs.remove(_rollKey);
    notifyListeners();
  }
}

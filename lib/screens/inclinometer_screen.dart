import 'package:flutter/material.dart';
import '../painters/bubble_level_painter.dart';
import '../sheets/angles_log_sheet.dart';
import '../theme/gravixor_theme.dart';

class InclinometerScreen extends StatefulWidget {
  const InclinometerScreen({super.key});

  @override
  State<InclinometerScreen> createState() => _InclinometerScreenState();
}

class _InclinometerScreenState extends State<InclinometerScreen> {
  double _pitch = 0.4;
  double _roll = -0.2;
  final bool _isHoldLocked = false;

  final List<Map<String, dynamic>> _savedLogs = [
    {'label': 'Granite Kitchen Counter', 'pitch': '0.1 deg', 'roll': '0.2 deg'},
    {'label': 'Solar Panel Roof Angle', 'pitch': '32.4 deg', 'roll': '0.5 deg'},
    {'label': 'Workshop Drill Press Table', 'pitch': '0.0 deg', 'roll': '0.0 deg'},
  ];

  bool get _isLevel => _pitch.abs() <= 0.5 && _roll.abs() <= 0.5;

  void _openLogsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => AnglesLogSheet(logs: _savedLogs),
    );
  }

  void _recordCurrentAngle() {
    setState(() {
      _savedLogs.insert(0, {
        'label': 'Surface #${_savedLogs.length + 1}',
        'pitch': '${_pitch.toStringAsFixed(1)} deg',
        'roll': '${_roll.toStringAsFixed(1)} deg',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Angle measurement saved to telemetry log')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gravixor Inclinometer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Measurement History',
            onPressed: _openLogsSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Pitch & Roll Digital Readouts
              Row(
                children: [
                  Expanded(child: _buildAngleCard('PITCH (Y-AXIS)', '${_pitch.toStringAsFixed(1)} deg', GravixorTheme.cyan)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildAngleCard('ROLL (X-AXIS)', '${_roll.toStringAsFixed(1)} deg', GravixorTheme.emerald)),
                ],
              ),
              const SizedBox(height: 24),

              // Bullseye Bubble Level CustomPaint
              Center(
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: CustomPaint(
                    painter: BubbleLevelPainter(
                      pitch: _pitch,
                      roll: _roll,
                      isLevel: _isLevel,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Level Status Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isLevel ? GravixorTheme.emerald.withValues(alpha: 0.2) : Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _isLevel ? GravixorTheme.emerald : Colors.white24),
                ),
                child: Text(
                  _isLevel ? 'TRUE LEVEL ACHIEVED (< 0.5 deg)' : 'UNEVEN SURFACE ALIGNMENT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: _isLevel ? GravixorTheme.emerald : GravixorTheme.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Interactive Simulated Tilt Sliders
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: GravixorTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Simulate Tilt Pitch:', style: TextStyle(fontSize: 12, color: GravixorTheme.textSecondary)),
                        Text('${_pitch.toStringAsFixed(1)} deg', style: const TextStyle(fontWeight: FontWeight.bold, color: GravixorTheme.cyan)),
                      ],
                    ),
                    Slider(
                      value: _pitch,
                      min: -15.0,
                      max: 15.0,
                      activeColor: GravixorTheme.cyan,
                      inactiveColor: Colors.white12,
                      onChanged: _isHoldLocked ? null : (val) => setState(() => _pitch = val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Simulate Tilt Roll:', style: TextStyle(fontSize: 12, color: GravixorTheme.textSecondary)),
                        Text('${_roll.toStringAsFixed(1)} deg', style: const TextStyle(fontWeight: FontWeight.bold, color: GravixorTheme.emerald)),
                      ],
                    ),
                    Slider(
                      value: _roll,
                      min: -15.0,
                      max: 15.0,
                      activeColor: GravixorTheme.emerald,
                      inactiveColor: Colors.white12,
                      onChanged: _isHoldLocked ? null : (val) => setState(() => _roll = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: GravixorTheme.textPrimary,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        setState(() {
                          _pitch = 0.0;
                          _roll = 0.0;
                        });
                      },
                      icon: const Icon(Icons.restore_rounded),
                      label: const Text('Zero Calibrate'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GravixorTheme.cyan,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _recordCurrentAngle,
                      icon: const Icon(Icons.bookmark_add_rounded),
                      label: const Text('Log Angle', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAngleCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GravixorTheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: GravixorTheme.textSecondary)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}

import '../app/brand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme.dart';
import 'gravixor_store.dart';

class GravixorHome extends StatefulWidget {
  const GravixorHome({super.key});

  @override
  State<GravixorHome> createState() => _GravixorHomeState();
}

class _GravixorHomeState extends State<GravixorHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const BullseyeLevelScreen(),
    const TiltMeterScreen(),
    const CalibrationScreen(),
    const MeasurementHistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GravixorStore>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(
        title: Text('Gravixor Dashboard', style: AppTheme.display(cInk)),
        backgroundColor: cSurface,
      ),
      body: Column(
        children: [
          Expanded(child: _screens[_currentIndex]),
          Container(
            color: cSurface,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDashItem(0, Icons.adjust, 'Bullseye'),
                _buildDashItem(1, Icons.screen_rotation, 'Tilt'),
                _buildDashItem(2, Icons.build, 'Calibrate'),
                _buildDashItem(3, Icons.history, 'History'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDashItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _currentIndex == index ? cAccent : cEdge),
          Text(label, style: AppTheme.text(_currentIndex == index ? cAccent : cEdge)),
        ],
      ),
    );
  }
}

class BullseyeLevelScreen extends StatelessWidget {
  const BullseyeLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: cAccent, width: 4),
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cAccent2,
            ),
          ),
        ),
      ),
    );
  }
}

class TiltMeterScreen extends StatelessWidget {
  const TiltMeterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pitch: 2.4°\\nRoll: -1.1°', style: AppTheme.display(cInk), textAlign: TextAlign.center),
    );
  }
}

class CalibrationScreen extends StatelessWidget {
  const CalibrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: cAccent),
        onPressed: () {},
        child: const Text('Calibrate Level'),
      ),
    );
  }
}

class MeasurementHistoryScreen extends StatelessWidget {
  const MeasurementHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<GravixorStore>();
    return ListView.builder(
      itemCount: store.history.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(store.history[index], style: AppTheme.text(cInk)),
          leading: const Icon(Icons.straighten, color: cAccent),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/gravixor_theme.dart';

class AnglesLogSheet extends StatelessWidget {
  final List<Map<String, dynamic>> logs;

  const AnglesLogSheet({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: GravixorTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Recorded Surface Telemetry',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: GravixorTheme.textPrimary),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logs.length,
            separatorBuilder: (context, _) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final log = logs[i];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: GravixorTheme.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(log['label'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: GravixorTheme.textPrimary)),
                    Text(
                      'Pitch: ${log['pitch']}  *  Roll: ${log['roll']}',
                      style: const TextStyle(color: GravixorTheme.cyan, fontFamily: 'monospace', fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

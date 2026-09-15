import 'package:flutter/material.dart';

class BubbleLevelPainter extends CustomPainter {
  final double pitch; // degrees (-45 to 45)
  final double roll;  // degrees (-45 to 45)
  final bool isLevel;

  const BubbleLevelPainter({
    required this.pitch,
    required this.roll,
    required this.isLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.9;

    // Outer spirit level frame
    final framePaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, framePaint);

    final borderPaint = Paint()
      ..color = isLevel ? const Color(0xFF10B981) : const Color(0xFF38BDF8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius, borderPaint);

    // Degree concentric rings (1 deg, 3 deg, 5 deg tolerance rings)
    final ringPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius * 0.2, ringPaint);
    canvas.drawCircle(center, radius * 0.45, ringPaint);
    canvas.drawCircle(center, radius * 0.7, ringPaint);

    // Center crosshairs
    final crosshairPaint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1.5;

    canvas.drawLine(Offset(center.dx - radius * 0.85, center.dy), Offset(center.dx + radius * 0.85, center.dy), crosshairPaint);
    canvas.drawLine(Offset(center.dx, center.dy - radius * 0.85), Offset(center.dx, center.dy + radius * 0.85), crosshairPaint);

    // Dynamic spirit bubble position
    final maxBubbleOffset = radius * 0.65;
    final bubbleX = center.dx + (roll / 15.0 * maxBubbleOffset).clamp(-maxBubbleOffset, maxBubbleOffset);
    final bubbleY = center.dy + (pitch / 15.0 * maxBubbleOffset).clamp(-maxBubbleOffset, maxBubbleOffset);

    // Bubble glow & fill
    final bubbleColor = isLevel ? const Color(0xFF10B981) : const Color(0xFF00E5FF);
    final bubblePaint = Paint()
      ..color = bubbleColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(bubbleX, bubbleY), 22, bubblePaint);

    // Bubble highlight reflection dot
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(bubbleX - 6, bubbleY - 6), 5, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant BubbleLevelPainter oldDelegate) {
    return oldDelegate.pitch != pitch || oldDelegate.roll != roll || oldDelegate.isLevel != isLevel;
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

class RedBalloonsOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const RedBalloonsOverlay({super.key, required this.onComplete});

  @override
  State<RedBalloonsOverlay> createState() => _RedBalloonsOverlayState();
}

class _RedBalloonsOverlayState extends State<RedBalloonsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_BalloonData> _balloons;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _balloons = List.generate(20, (_) => _BalloonData(rng));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _BalloonsPainter(
              progress: _controller.value,
              balloons: _balloons,
            ),
          );
        },
      ),
    );
  }
}

class _BalloonData {
  final double x;
  final double startDelay;
  final double speed;
  final double swayAmplitude;
  final double swayFrequency;
  final double size;
  final Color color;

  _BalloonData(Random rng)
      : x = rng.nextDouble(),
        startDelay = rng.nextDouble() * 0.3,
        speed = 0.7 + rng.nextDouble() * 0.3,
        swayAmplitude = 10 + rng.nextDouble() * 20,
        swayFrequency = 1 + rng.nextDouble() * 2,
        size = 22 + rng.nextDouble() * 16,
        color = Color.lerp(
          const Color(0xFFE53935),
          const Color(0xFFB71C1C),
          rng.nextDouble(),
        )!;
}

class _BalloonsPainter extends CustomPainter {
  final double progress;
  final List<_BalloonData> balloons;

  _BalloonsPainter({required this.progress, required this.balloons});

  @override
  void paint(Canvas canvas, Size size) {
    for (final b in balloons) {
      final adjustedProgress = ((progress - b.startDelay) / (1 - b.startDelay))
          .clamp(0.0, 1.0) *
          b.speed;
      if (adjustedProgress <= 0) continue;

      final opacity = adjustedProgress < 0.8
          ? 1.0
          : 1.0 - ((adjustedProgress - 0.8) / 0.2);

      final centerX =
          b.x * size.width + sin(adjustedProgress * b.swayFrequency * pi * 2) * b.swayAmplitude;
      final centerY = size.height * (1.1 - adjustedProgress * 1.3);

      final paint = Paint()..color = b.color.withValues(alpha: opacity.clamp(0.0, 1.0));

      final balloonRect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: b.size,
        height: b.size * 1.25,
      );
      canvas.drawOval(balloonRect, paint);

      final highlight = Paint()
        ..color = Colors.white.withValues(alpha: 0.3 * opacity.clamp(0.0, 1.0))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(
        Offset(centerX - b.size * 0.15, centerY - b.size * 0.2),
        b.size * 0.18,
        highlight,
      );

      final knot = Paint()..color = b.color.withValues(alpha: opacity.clamp(0.0, 1.0));
      canvas.drawCircle(
        Offset(centerX, centerY + b.size * 0.625),
        b.size * 0.08,
        knot,
      );

      final stringPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.5 * opacity.clamp(0.0, 1.0))
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      final path = Path()
        ..moveTo(centerX, centerY + b.size * 0.7)
        ..quadraticBezierTo(
          centerX + sin(adjustedProgress * pi * 3) * 5,
          centerY + b.size * 0.7 + b.size * 0.5,
          centerX + sin(adjustedProgress * pi * 2) * 3,
          centerY + b.size * 0.7 + b.size,
        );
      canvas.drawPath(path, stringPaint);
    }
  }

  @override
  bool shouldRepaint(_BalloonsPainter old) => old.progress != progress;
}

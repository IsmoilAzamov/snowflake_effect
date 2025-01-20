import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'dart:math' as math;

import '../constants/app_colors.dart';

class LoadingIndicator extends StatefulWidget {
  final String? message;
  final double size;

  // Warm, welcoming colors that represent inclusivity and support
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 200,
    this.primaryColor = const Color(0xFF4DA1A9), // Healing teal
    this.secondaryColor = const Color(0xFFF7A072), // Warm coral
    this.accentColor = const Color(0xFF7E77DD), // Gentle purple
  });

  @override
  State<LoadingIndicator> createState() => _CommunityMarketplaceLoaderState();
}

class _CommunityMarketplaceLoaderState extends State<LoadingIndicator> with TickerProviderStateMixin {
  late AnimationController _heartbeatController;
  late AnimationController _flowController;
  late AnimationController _circleController;
  late AnimationController _messageController;
  final List<_SupportCircle> _circles = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateCircles();
    _startAnimations();
  }

  void _initializeAnimations() {
    _heartbeatController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _flowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _circleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _messageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  void _generateCircles() {
    final random = math.Random();
    for (int i = 0; i < 5; i++) {
      _circles.add(_SupportCircle(
        angle: random.nextDouble() * math.pi * 2,
        size: 8 + random.nextDouble() * 4,
        orbitRadius: widget.size * 0.25,
        speed: 0.3 + random.nextDouble() * 0.3,
      ));
    }
  }

  void _startAnimations() {
    _heartbeatController.repeat(reverse: true);
    _flowController.repeat();
    _circleController.repeat();
    _messageController.forward();
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    _flowController.dispose();
    _circleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green[400]!.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]!),
                strokeWidth: 3,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: const Duration(seconds: 2))
              .rotate(duration: const Duration(seconds: 3)),


          // SizedBox(
          //   width: widget.size,
          //   height: widget.size,
          //   child: AnimatedBuilder(
          //     animation: Listenable.merge([
          //       _heartbeatController,
          //       _flowController,
          //       _circleController,
          //     ]),
          //     builder: (context, child) {
          //       return CustomPaint(
          //         painter: _CommunityMarketplacePainter(
          //           heartbeatValue: _heartbeatController.value,
          //           flowValue: _flowController.value,
          //           circleValue: _circleController.value,
          //           circles: _circles,
          //           primaryColor: AppColors.greenColor,
          //           secondaryColor: AppColors.yellowColor,
          //           accentColor: AppColors.greenColor,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          const SizedBox(height: 24),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _messageController,
              curve: Curves.easeOutBack,
            )),
            child: FadeTransition(
              opacity: _messageController,
              child: Text(
                widget.message ?? "${"loading".tr()}...",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportCircle {
  double angle;
  final double size;
  final double orbitRadius;
  final double speed;

  _SupportCircle({
    required this.angle,
    required this.size,
    required this.orbitRadius,
    required this.speed,
  });

  void update(double delta) {
    angle += speed * delta;
    if (angle > math.pi * 2) {
      angle -= math.pi * 2;
    }
  }
}

class _CommunityMarketplacePainter extends CustomPainter {
  final double heartbeatValue;
  final double flowValue;
  final double circleValue;
  final List<_SupportCircle> circles;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const _CommunityMarketplacePainter({
    required this.heartbeatValue,
    required this.flowValue,
    required this.circleValue,
    required this.circles,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    // Draw supporting hands shape
    _drawSupportingHands(canvas, center, radius);

    // Draw connecting circles representing community
    _drawCommunityCircles(canvas, center, radius);

    // Draw central heart
    _drawCentralHeart(canvas, center, radius);
  }

  void _drawSupportingHands(Canvas canvas, Offset center, double radius) {
    final path = Path();
    final handCount = 5;

    for (int i = 0; i < handCount; i++) {
      final angle = (i * math.pi * 2 / handCount) + flowValue * math.pi * 2;
      final handPath = _createHandPath(center, radius, angle);
      path.addPath(handPath, Offset.zero);
    }

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.7),
          primaryColor.withValues(alpha: 0.3),
        ],
        stops: const [0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.5))
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  Path _createHandPath(Offset center, double radius, double angle) {
    final path = Path();
    final handLength = radius * 0.8;
    final handWidth = radius * 0.2;

    final x = center.dx + math.cos(angle) * radius;
    final y = center.dy + math.sin(angle) * radius;

    path.moveTo(x, y);
    path.quadraticBezierTo(
      center.dx + math.cos(angle + 0.3) * handLength,
      center.dy + math.sin(angle + 0.3) * handLength,
      center.dx + math.cos(angle) * (radius + handWidth),
      center.dy + math.sin(angle) * (radius + handWidth),
    );

    return path;
  }

  void _drawCommunityCircles(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    for (final circle in circles) {
      circle.update(0.016);

      final x = center.dx + math.cos(circle.angle) * circle.orbitRadius;
      final y = center.dy + math.sin(circle.angle) * circle.orbitRadius;

      // Draw connection lines
      canvas.drawLine(
        center,
        Offset(x, y),
        Paint()
          ..color = secondaryColor.withValues(alpha: 0.2)
          ..strokeWidth = 1,
      );

      // Draw circle
      canvas.drawCircle(
        Offset(x, y),
        circle.size * (0.8 + heartbeatValue * 0.2),
        paint..color = secondaryColor.withValues(alpha: 0.8),
      );
    }
  }

  void _drawCentralHeart(Canvas canvas, Offset center, double radius) {
    final heartSize = radius * (0.4 + heartbeatValue * 0.1);
    final heartPath = _createHeartPath(center, heartSize);

    // Draw heart glow
    canvas.drawPath(
      heartPath,
      Paint()
        ..color = accentColor.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15),
    );

    // Draw heart
    canvas.drawPath(
      heartPath,
      Paint()
        ..color = accentColor
        ..style = PaintingStyle.fill,
    );
  }

  Path _createHeartPath(Offset center, double size) {
    final path = Path();
    path.moveTo(center.dx, center.dy + size * 0.3);

    // Left curve
    path.cubicTo(
      center.dx - size * 0.4,
      center.dy,
      center.dx - size * 0.4,
      center.dy - size * 0.3,
      center.dx,
      center.dy - size * 0.3,
    );

    // Right curve
    path.cubicTo(
      center.dx + size * 0.4,
      center.dy - size * 0.3,
      center.dx + size * 0.4,
      center.dy,
      center.dx,
      center.dy + size * 0.3,
    );

    return path;
  }

  @override
  bool shouldRepaint(_CommunityMarketplacePainter oldDelegate) =>
      heartbeatValue != oldDelegate.heartbeatValue ||
      flowValue != oldDelegate.flowValue ||
      circleValue != oldDelegate.circleValue;
}

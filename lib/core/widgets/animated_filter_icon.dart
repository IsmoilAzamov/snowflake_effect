


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedFilterIcon extends StatefulWidget {
  final ValueNotifier<bool> isActiveNotifier;
  final double size;
  final Duration duration;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback? onTap;
  final bool enableHapticFeedback;

  const AnimatedFilterIcon({
    super.key,
    required this.isActiveNotifier,
    this.size = 16.0,
    this.duration = const Duration(milliseconds: 300),
    this.activeColor = Colors.grey,
    this.inactiveColor = Colors.blue,
    this.onTap,
    this.enableHapticFeedback = true,
  });

  @override
  State<AnimatedFilterIcon> createState() => _AnimatedFilterIconState();
}

class _AnimatedFilterIconState extends State<AnimatedFilterIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _barHeightAnimation1;
  late Animation<double> _barHeightAnimation2;
  late Animation<double> _barHeightAnimation3;
  late Animation<double> _opacityAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _setupAnimations();

    // Set initial value without animation
    if (widget.isActiveNotifier.value) {
      _controller.value = 1.0;
    }

    widget.isActiveNotifier.addListener(_handleStateChange);
    _isInitialized = true;
  }

  void _setupAnimations() {
    const Curve curve = Curves.easeInOutCubic;

    _barHeightAnimation1 = Tween<double>(begin: 0.80, end: 0.65).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: curve),
      ),
    );

    _barHeightAnimation2 = Tween<double>(begin: 0.65, end: 0.50).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: curve),
      ),
    );

    _barHeightAnimation3 = Tween<double>(begin: 0.50, end: 0.35).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: curve),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curve,
      ),
    );
  }

  void _handleStateChange() {
    // Only animate if the widget is fully initialized
    if (!_isInitialized) return;

    if (widget.isActiveNotifier.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleTap() {
    if (widget.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    // widget.isActiveNotifier.value = !widget.isActiveNotifier.value;
    widget.onTap?.call();
  }

  @override
  void dispose() {
    widget.isActiveNotifier.removeListener(_handleStateChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _FilterIconPainter(
                barHeight1: _barHeightAnimation1.value,
                barHeight2: _barHeightAnimation2.value,
                barHeight3: _barHeightAnimation3.value,
                opacity: _opacityAnimation.value,
                color: Color.lerp(
                  widget.inactiveColor,
                  widget.activeColor,
                  _controller.value,
                )!,
                strokeWidthFactor: 0.05,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FilterIconPainter extends CustomPainter {
  final double barHeight1;
  final double barHeight2;
  final double barHeight3;
  final double opacity;
  final Color color;
  final double strokeWidthFactor;

  _FilterIconPainter({
    required this.barHeight1,
    required this.barHeight2,
    required this.barHeight3,
    required this.opacity,
    required this.color,
    this.strokeWidthFactor = 0.01,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = size.width * strokeWidthFactor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final startX = size.width * 0.36;
    final spacing = size.height * 0.12;
    final startY = size.height * 0.35;

    void drawBar(double y, double endX) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(size.width * endX, y),
        paint,
      );
    }

    drawBar(startY, barHeight1);
    drawBar(startY + spacing, barHeight2);
    drawBar(startY + spacing * 2, barHeight3);
  }

  @override
  bool shouldRepaint(_FilterIconPainter oldDelegate) =>
      barHeight1 != oldDelegate.barHeight1 ||
          barHeight2 != oldDelegate.barHeight2 ||
          barHeight3 != oldDelegate.barHeight3 ||
          opacity != oldDelegate.opacity ||
          color != oldDelegate.color ||
          strokeWidthFactor != oldDelegate.strokeWidthFactor;
}
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

Widget seasonalEffectWidget(Range sizeRange) {
  if (DateTime.now().month == 12 && DateTime.now().day >= 11 ||
      DateTime.now().month == 1 && DateTime.now().day <= 19) {
    return SizedBox(
      height: MediaQuery.of(navigatorKey.currentContext!).size.height,
      child: SeasonalEffect(
        assetPath: "assets/seasonal/snowflake.png",
        sizeRange: sizeRange,
      ),
    );
  }
  if (DateTime.now().month == 3 && DateTime.now().day >= 1 ||
      DateTime.now().month == 4 && DateTime.now().day <= 12) {
    return SizedBox(
      height: MediaQuery.of(navigatorKey.currentContext!).size.height,
      child: SeasonalEffect(
        assetPath: "assets/seasonal/petal.png",
        sizeRange: Range(10, 12),
      ),
    );
  }
  return const SizedBox();
}

class SeasonalEffect extends StatefulWidget {
  final String assetPath;
  final Range sizeRange;

  const SeasonalEffect({
    super.key,
    required this.assetPath,
    required this.sizeRange,
  });

  @override
  State<SeasonalEffect> createState() => _SeasonalEffectState();
}

class _SeasonalEffectState extends State<SeasonalEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();
  ui.Image? _snowflakeImage;
  int snowflakeType = 0;
  late SeasonConfig config;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    config = SeasonConfig(
      particleCount: 28,
      sizeRange: widget.sizeRange,
      speedRange: Range(0.1, 0.3),
      windVariation: 0.1,
    );

    _loadSnowflakeImages();
    _initializeParticles();
  }

  Future<void> _loadSnowflakeImages() async {
    _snowflakeImage = await loadImageFromAsset(widget.assetPath);

    // Force a rebuild once images are loaded
    if (mounted) setState(() {});
  }

  Future<ui.Image> loadImageFromAsset(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo frameInfo = await codec.getNextFrame();

    return frameInfo.image;
  }


  void _initializeParticles() {
    _particles = List.generate(
      config.particleCount,
      (index) => Particle(
        x: _random.nextDouble(),
        y: -0.2 - _random.nextDouble() * 0.8,
        // Start above the visible area
        size: _random.nextDouble() *
                (config.sizeRange.max - config.sizeRange.min) +
            config.sizeRange.min,
        speed: _random.nextDouble() *
                (config.speedRange.max - config.speedRange.min) +
            config.speedRange.min,
        angle: _random.nextDouble() * pi * 2,
        spinSpeed: (_random.nextDouble() - 0.5) * 0.02,
        // Reduced spin speed
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only build if images are loaded
    if (_snowflakeImage == null) {
      return const SizedBox.shrink(); // Or a loading indicator
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            particles: _particles,
            config: config,
            animation: _controller.value,
            snowflakeImage: _snowflakeImage!,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final SeasonConfig config;
  final double animation;
  final ui.Image snowflakeImage;

  ParticlePainter({
    required this.particles,
    required this.config,
    required this.animation,
    required this.snowflakeImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Update particle position with slower movement
      particle.y += particle.speed * 0.003; // Reduced movement speed
      particle.x += sin(particle.angle) * config.windVariation * 0.002;
      particle.angle += particle.spinSpeed;

      // Reset particle when it goes off screen
      if (particle.y > 1.2) {
        // Allow to go slightly below screen
        particle.y = -0.2; // Reset above screen
        particle.x = Random().nextDouble();
      }

      final point = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      canvas.save();
      canvas.translate(point.dx, point.dy);
      canvas.rotate(particle.angle);

      // Draw image-based snowflake
      final image = snowflakeImage;
      final paint = Paint();

      // Calculate scale based on particle size
      final scale = particle.size / image.width;

      canvas.scale(scale);
      canvas.drawImage(
          image, Offset(-image.width / 2, -image.height / 2), paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
// ... Rest of the classes (Particle, SeasonConfig, Range) remain the same ...

@override
bool shouldRepaint(CustomPainter oldDelegate) => true;

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double angle;
  double spinSpeed;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.angle,
    required this.spinSpeed,
  });
}

class SeasonConfig {
  final int particleCount;
  final Range speedRange;
  final Range sizeRange;
  final double windVariation;

  SeasonConfig({
    required this.particleCount,
    required this.speedRange,
    required this.sizeRange,
    required this.windVariation,
  });
}

class Range {
  final double min;
  final double max;

  Range(this.min, this.max);
}

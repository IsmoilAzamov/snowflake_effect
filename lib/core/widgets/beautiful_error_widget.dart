import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../constants/app_colors.dart';

class FluidErrorWidget extends StatefulWidget {
  final String? message;
  final String? subMessage;
  final VoidCallback? onRetry;
  final Color primaryColor;
  final Color secondaryColor;
  final double scale;

  const FluidErrorWidget({
    super.key,
     this.message,
    this.subMessage,
    this.onRetry,
    this.primaryColor = const Color(0xFF649960),
    this.secondaryColor = const Color(0xFF8FBE88),
    this.scale=1,
  });

  @override
  State<FluidErrorWidget> createState() => _FluidErrorWidgetState();
}

class _FluidErrorWidgetState extends State<FluidErrorWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    );

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    _floatAnimation = CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    );

    // Start continuous animations
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _rotationController,
          _pulseController,
          _floatController,
        ]),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedErrorContainer(),
               SizedBox(height: 40*widget.scale,),
              _buildMessages(),
              if (widget.onRetry != null) _buildRetryButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedErrorContainer() {
    return Transform.translate(
      offset: Offset(0, math.sin(_floatAnimation.value * math.pi) * 6),
      child: SizedBox(
        width: 280*widget.scale,
        height: 160*widget.scale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating border
            Transform.rotate(
              angle: _rotationAnimation.value * 2 * math.pi,
              child: Container(
                width: 140*widget.scale,
                height: 140*widget.scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: widget.primaryColor.withValues(alpha: 0.2),
                    width: 2*widget.scale,
                  ),
                ),
              ),
            ),

            // Pulsing border
            Transform.scale(
              scale: 0.9 + (_pulseAnimation.value * 0.1),
              child: Container(
                width: 120*widget.scale,
                height: 120*widget.scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.primaryColor.withValues(alpha: 0.3),
                    width: 2*widget.scale,
                  ),
                ),
              ),
            ),

            // Main container with outlined design
            Container(
              width: 100*widget.scale,
              height: 100*widget.scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.primaryColor,
                  width: 2,
                ),
              ),
              child:  Center(
                child: Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.redColor,
                  size: 48*widget.scale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            widget.message??"something_went_wrong".tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14*widget.scale,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.subMessage != null) ...[
             SizedBox(height: 8*widget.scale),
            Text(
              widget.subMessage!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF649960).withValues(alpha: 0.7),
                fontSize: 12*widget.scale,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return Padding(
      padding:  EdgeInsets.only(top: 32*widget.scale),
      child: OutlinedButton.icon(
        onPressed: widget.onRetry,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: widget.primaryColor,
          side: BorderSide(color: widget.primaryColor, width: 2*widget.scale),
          padding:  EdgeInsets.symmetric(
            horizontal: 32*widget.scale,
            vertical: 16*widget.scale,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30*widget.scale),
          ),
        ),
        icon:  Icon(Icons.refresh_rounded, color: widget.primaryColor),
        label:  Text(
          'retry'.tr(),
          style: TextStyle(
            fontSize: 16*widget.scale,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
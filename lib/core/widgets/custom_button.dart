import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final IconData? icon;
  final Widget? prefix;
  final bool isEnabled;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor = AppColors.greenColor,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.elevation = 0.5,
    this.icon,
    this.prefix,
    this.isEnabled = true,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final bool loading = isLoading ?? false;
    final Color effectiveBackgroundColor = !isEnabled
        ? Colors.grey.shade400
        : loading
            ? backgroundColor.withOpacity(0.7)
            : backgroundColor;

    final Color effectiveTextColor = !isEnabled ? Colors.white.withOpacity(0.7) : textColor;

    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: isEnabled && !loading ? elevation : 0,
        borderRadius: BorderRadius.circular(borderRadius),
        color: effectiveBackgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: (isEnabled && !loading) ? onPressed : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Loading Indicator
                if (loading)
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                    ),
                  ),

                // Button Content
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: loading ? 0.0 : 1.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (prefix != null) ...[
                        prefix!,
                        const SizedBox(width: 8.0),
                      ],
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: effectiveTextColor,
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          color: effectiveTextColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class DownloadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  // Adding a disabled state for better UX
  final bool isDisabled;
  // Optional tooltip message for accessibility
  final String? tooltipMessage;

  const DownloadButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.tooltipMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap with Tooltip for accessibility and better UX
    return Tooltip(
      message: tooltipMessage ?? 'Download',
      // Prevent tooltip when button is loading or disabled
      waitDuration: isLoading || isDisabled
          ? Duration.zero
          : const Duration(milliseconds: 800),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Main button
            Opacity(
              // Reduce opacity when disabled
              opacity: isDisabled ? 0.5 : 1.0,
              child: InkWell(
                onTap: isDisabled || isLoading ? null : () {
                  // Add haptic feedback for better interaction
                  HapticFeedback.lightImpact();
                  onPressed();
                },
                // Custom ink effect color
                splashColor: AppColors.blueColor.withOpacity(0.1),
                highlightColor: AppColors.blueColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.lightBgBlue,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 0.5,
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLoading
                        ? Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.blueColor,
                          ),
                        ),
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.download_rounded,
                        size: 18,
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Ripple effect container
            if (!isLoading && !isDisabled)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onPressed,
                    borderRadius: BorderRadius.circular(8),
                    splashColor: AppColors.blueColor.withOpacity(0.1),
                    highlightColor: AppColors.blueColor.withOpacity(0.05),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
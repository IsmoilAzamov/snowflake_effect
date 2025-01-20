import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MinimalCertificateWidget extends StatefulWidget {
  final String title;
  final Future<void> Function(void Function(double progress) onProgress)? onDownload;
  final VoidCallback? onLaunch;

  const MinimalCertificateWidget({
    super.key,
    required this.title,
    this.onDownload,
    this.onLaunch,
  });

  @override
  State<MinimalCertificateWidget> createState() => _MinimalCertificateWidgetState();
}

class _MinimalCertificateWidgetState extends State<MinimalCertificateWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDownloading = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // For smooth progress updates
    );
  }

  void _startDownload() async {
    if (widget.onDownload == null) return;

    setState(() {
      _isDownloading = true;
      _progress = 0;
    });

    try {
      await widget.onDownload!((progress) {
        setState(() => _progress = progress);
      });

      // Ensure we reach 100% at the end
      setState(() => _progress = 1.0);

      // Wait a moment at 100% before resetting
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.1),
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.02),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Certificate Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Certificate',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Download Button
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return InkWell(
                              onTap: _isDownloading ? null : _startDownload,
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blue[700]!,
                                      Colors.blue[500]!,
                                    ],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    // Progress Overlay
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: FractionallySizedBox(
                                        widthFactor: _progress,
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.green[700]!,
                                                Colors.green[500]!,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Button Content
                                    Center(
                                      child: _isDownloading
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    value: _progress,
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${(_progress * 100).toInt()}%',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.cloudArrowDown,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  'download'.tr(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //download button
                      if (widget.onDownload != null) const SizedBox(width: 8),
                      if (widget.onLaunch != null)
                        GestureDetector(
                          onTap: () => widget.onLaunch?.call(),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF007AFF).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.fileArrowDown,
                              color: Color(0xFF007AFF),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TapCertificateWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onDownload;

  const TapCertificateWidget({
    super.key,
    required this.title,
    this.onDownload,
  });

  @override
  State<TapCertificateWidget> createState() => _TapCertificateWidgetState();
}

class _TapCertificateWidgetState extends State<TapCertificateWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _downloadProgress;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _downloadProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isDownloading = false);
        widget.onDownload?.call();
        _controller.reset();
      }
    });
  }

  void _startDownload() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    await _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _downloadProgress,
      builder: (context, child) {
        return GestureDetector(
          onTap: _startDownload,
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                // Main Certificate Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.2)
                                : Colors.black.withValues(alpha: 0.1),
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.02),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          // Download Progress Overlay
                          if (_isDownloading)
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FractionallySizedBox(
                                  widthFactor: _downloadProgress.value,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withValues(alpha: 0.1),
                                          Colors.blue.withValues(alpha: 0.05),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          // Certificate Content
                          Row(
                            children: [
                              // Icon Section
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: _isDownloading
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          value: _downloadProgress.value,
                                          strokeWidth: 2,
                                          color: Colors.blue,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                        size: 24,
                                      ),
                              ),
                              const SizedBox(width: 16),

                              // Text Content
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Certificate',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              // Download Status
                              if (_isDownloading) ...[
                                const SizedBox(width: 12),
                                Text(
                                  '${(_downloadProgress.value * 100).toInt()}%',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ] else ...[
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.download_rounded,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_ihma/core/constants/app_colors.dart';
import 'package:my_ihma/core/widgets/beautiful_error_widget.dart';
import 'package:my_ihma/core/widgets/product_widget/product_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const MyImageViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<MyImageViewer> createState() => _MyImageViewerState();
}

class _MyImageViewerState extends State<MyImageViewer>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int _currentIndex;
  bool _isInfoVisible = true;
  late AnimationController _animationController;
  final ValueNotifier<double> _scaleNotifier = ValueNotifier(1.0);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _scaleNotifier.dispose();
    super.dispose();
  }

  void _toggleInfoVisibility() {
    setState(() {
      _isInfoVisible = !_isInfoVisible;
      if (_isInfoVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.background,
      body: GestureDetector(
        onTap: _toggleInfoVisibility,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image Gallery
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: _pageController,
              itemCount: widget.imageUrls.length,
              backgroundDecoration: BoxDecoration(
                color: colors.surface,
              ),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(widget.imageUrls[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  heroAttributes: PhotoViewHeroAttributes(tag: 'image-$index'),

                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: FluidErrorWidget());
                  },

                  // scaleStateChangedCallback: (state) {
                  //   _scaleNotifier.value = state.scaleState == PhotoViewScaleState.initial ? 1.0 : state.scale ?? 1.0;
                  // },
                );
              },
              loadingBuilder: (context, event) => Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                (event.expectedTotalBytes ?? 1),
                        color: colors.primary,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                      if (event != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          '${((event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1)) * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
            ),

            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                offset: Offset(0, _isInfoVisible ? 0 : -1),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isInfoVisible ? 1.0 : 0.0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: colors.surface.withValues(alpha: 0.7),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          bottom: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "view".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            _buildIconButton(
                              Icons.close,
                              () => Navigator.pop(context),
                              colors,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                offset: Offset(0, _isInfoVisible ? 0 : 1),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isInfoVisible ? 1.0 : 0.0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: colors.surface.withValues(alpha: 0.7),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom + 16,
                          top: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${_currentIndex + 1} / ${widget.imageUrls.length}',
                              style: TextStyle(
                                color: colors.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (widget.imageUrls.length > 1) ...[
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 64,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.imageUrls.length,
                                  itemBuilder: (context, index) {
                                    final bool isSelected =
                                        _currentIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        _pageController.animateToPage(
                                          index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      child: Container(
                                        width: 64,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.greenColor
                                                : colors
                                                    .surfaceContainerHighest,
                                            width: 2,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: AppColors.greenColor
                                                        .withValues(alpha: 0.3),
                                                    blurRadius: 6,
                                                    spreadRadius: 0.5,
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ImageSection(
                                                imageUrl:
                                                    widget.imageUrls[index],
                                                radius: 0,
                                              ),
                                              if (isSelected)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.greenColor
                                                        .withValues(alpha: 0.2),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ).animate(
                                        effects: [
                                          FadeEffect(
                                            duration: const Duration(
                                                milliseconds: 300),
                                          ),
                                          ScaleEffect(
                                            begin: const Offset(0.8, 0.8),
                                            end: const Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation buttons
            if (widget.imageUrls.length > 1)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isInfoVisible ? 1.0 : 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavigationButton(
                      icon: Icons.chevron_left,
                      onPressed: _currentIndex > 0
                          ? () {
                              HapticFeedback.lightImpact();
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      colors: colors,
                    ),
                    _buildNavigationButton(
                      icon: Icons.chevron_right,
                      onPressed: _currentIndex < widget.imageUrls.length - 1
                          ? () {
                              HapticFeedback.heavyImpact();
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      colors: colors,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    VoidCallback onPressed,
    ColorScheme colors,
  ) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.gray.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: colors.onSurface),
        visualDensity: VisualDensity.compact,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required ColorScheme colors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: onPressed != null
                ? AppColors.greenColor
                : AppColors.greenColor.withValues(alpha: 0.3),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

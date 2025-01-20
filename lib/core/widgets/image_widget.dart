import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../di/di.dart';
import 'image_bloc/image_bloc.dart';
import 'image_bloc/image_event.dart';
import 'image_bloc/image_state.dart';


class ImageWidget extends StatelessWidget {
  final String url;
  final double? width;
  final bool isCircular;
  final double? height;
  final double? borderRadius;
  final Widget? errorWidget;
  final BoxFit fit;
  final Duration animationDuration;

  const ImageWidget({
    super.key,
    required this.url,
    this.width,
    this.isCircular = false,
    this.height,
    this.borderRadius,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    assert(url.isNotEmpty, 'Image URL cannot be empty.');
    return BlocProvider(
      create: (_) => sl<ImageBloc>()..add(GetImageEvent(url: url)),
      child: _ImageContent(
        width: width,
        height: height,
        isCircular: isCircular,
        borderRadius: borderRadius,
        errorWidget: errorWidget,
        fit: fit,
        animationDuration: animationDuration,
      ),
    );
  }
}

class _ImageContent extends StatelessWidget {
  final double? width;
  final bool isCircular;
  final double? height;
  final double? borderRadius;
  final Widget? errorWidget;
  final BoxFit fit;
  final Duration animationDuration;

  const _ImageContent({
    required this.width,
    required this.isCircular,
    required this.height,
    required this.borderRadius,
    required this.errorWidget,
    required this.fit,
    required this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? 120.0;
    final effectiveHeight = height ?? width ?? 100.0;
    final effectiveBorderRadius = isCircular
        ? BorderRadius.circular(effectiveWidth / 2)
        : BorderRadius.circular(borderRadius ?? 0);

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: animationDuration,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _buildStateWidget(
            state,
            effectiveWidth,
            effectiveHeight,
            effectiveBorderRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildStateWidget(
      ImageState state,
      double width,
      double height,
      BorderRadius borderRadius,
      ) {
    if (state is ImageLoadingState) {
      return _buildLoadingPlaceholder(width, height, borderRadius);
    } else if (state is ImageLoadedState) {
      return _buildImageWithAnimation(state, width, height, borderRadius);
    } else {
      return _buildError(width, height);
    }
  }

  Widget _buildLoadingPlaceholder(
      double width,
      double height,
      BorderRadius borderRadius,
      ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
    );
  }

  Widget _buildImageWithAnimation(
      ImageLoadedState state,
      double width,
      double height,
      BorderRadius borderRadius,
      ) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: TweenAnimationBuilder<double>(
        duration: animationDuration,
        tween: Tween<double>(begin: 0.8, end: 1.0),
        curve: Curves.easeOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: scale,
              child: Image.memory(
                state.bytes,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (_, __, ___) => _buildError(width, height),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildError(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: errorWidget ??
            FaIcon(
              FontAwesomeIcons.image,
              color: Colors.grey,
              size: width * 0.3,
            ),
      ),
    );
  }
}

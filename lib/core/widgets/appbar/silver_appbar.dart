import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_ihma/core/constants/urls.dart';

import '../../../client/domain/entities/product/product_entity.dart';
import '../../constants/app_colors.dart';
import '../image_preview_page.dart';
import '../product_widget/product_widget.dart';

class GlassmorphicSliverAppBar extends StatefulWidget {
  final List<PhotoEntity> photos;
  final double expandedHeight;

  const GlassmorphicSliverAppBar({
    super.key,
    required this.photos,
    this.expandedHeight = 400,
  });

  @override
  State<GlassmorphicSliverAppBar> createState() =>
      _GlassmorphicSliverAppBarState();
}

class _GlassmorphicSliverAppBarState extends State<GlassmorphicSliverAppBar> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: false,
      expandedHeight: widget.expandedHeight,
      pinned: false,
      stretch: false,
      floating: false,
      leading: SizedBox(),
      backgroundColor: Colors.transparent,
      // systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
      //     ? SystemUiOverlayStyle.light.copyWith()
      //     : SystemUiOverlayStyle.dark.copyWith(
      //   systemNavigationBarColor: ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image Carousel
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: widget.expandedHeight,
                viewportFraction: 1,
                autoPlay: widget.photos.length > 1,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() => _currentImageIndex = index);
                },
              ),
              items: widget.photos.map((photo) {
                return Hero(
                  tag: 'product-photo-${photo.id}',
                  child: ImageSection(
                    imageUrl:
                        'https://my.ihma.uz/api/Pom/Product/DownloadPhoto/${photo.id}',
                    radius: 0,

                  ),
                );
              }).toList(),
            ),

            if (widget.photos.length > 1)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Navigation arrows

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.photos.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _carouselController.animateToPage(entry.key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentImageIndex == entry.key ? 24 : 12,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.greenColor.withValues(
                                alpha:
                                    _currentImageIndex == entry.key ? 0.9 : 0.4,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            //back button
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.back, color: Colors.white),
                ),
              ),
            ),

            Positioned(
              top: 40,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyImageViewer(
                        imageUrls: widget.photos
                            .map((e) =>
                                "${DOMAIN}api/Pom/Product/DownloadPhoto/${e.id}")
                            .toList(),
                        initialIndex: 0,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(Icons.remove_red_eye_outlined, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

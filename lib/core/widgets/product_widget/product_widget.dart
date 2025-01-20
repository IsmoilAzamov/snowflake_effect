import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_ihma/core/constants/app_colors.dart';
import 'package:my_ihma/core/utils/get_sums_fixed.dart';
import 'package:my_ihma/core/widgets/beautiful_error_widget.dart';

import '../../../client/domain/entities/product/product_entity.dart';
import '../../components/skleton/skelton.dart';
import '../../constants/urls.dart';
import '../image_preview_page.dart';

class EnhancedProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  // Memoize the image URL

  const EnhancedProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageSection(
                      imageUrl:
                          "https://my.ihma.uz/api/Pom/Product/DownloadPhoto/${product.photoId ?? ""}"),
                  Positioned(
                    top: 6,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyImageViewer(
                              imageUrls: [
                                "${DOMAIN}api/Pom/Product/DownloadPhoto/${product.photoId}"
                              ],
                              initialIndex: 0,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _ProductDetails(product: product),
            ],
          ),
        ),
      ),
    );
  }
}

// Separate stateless widget for image section
class ImageSection extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const ImageSection({super.key, required this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius ?? 12)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => Skeleton(),
          errorWidget: (context, url, error) => FluidErrorWidget(scale: 0.5,),
          fit: BoxFit.cover,
          memCacheWidth: 400,
          // Optimize for typical screen width
          fadeInDuration: const Duration(milliseconds: 150),
          fadeOutDuration: const Duration(milliseconds: 150),
          cacheKey: imageUrl,
        ),
      ),
    );
  }
}

// Separate stateless widget for product details
class _ProductDetails extends StatelessWidget {
  final ProductEntity product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.brand != null) ...[
            Text(
              product.brand!,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
          ],
          Text(
            product.title ?? "-",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.2,
              fontSize: 14,
              letterSpacing: 0.15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            "${product.minPrice ?? 0} - ${getSumsFixed(text: (product.maxPrice ?? 0).toString())}",
            style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.2,
                fontSize: 12,
                letterSpacing: 0.15,
                color: AppColors.greenColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          //rich text delivery_in: 1 - 5 days
          SizedBox(
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  fontSize: 12,
                  letterSpacing: 0.15,
                ),
                children: [
                  TextSpan(text: "${"delivery_in".tr()}: "),
                  TextSpan(
                    text:
                        "${product.minDeadlineDays ?? 0} - ${product.maxDeadlineDays ?? 0} ${"days".tr().toLowerCase()}",
                    style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        fontSize: 12,
                        letterSpacing: 0.15,
                        color: AppColors.greenColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

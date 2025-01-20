import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_ihma/client/domain/entities/product/product_entity.dart';
import 'package:my_ihma/client/presentation/bloc/product/procuct_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/product/product_event.dart';
import 'package:my_ihma/client/presentation/bloc/product/product_state.dart';
import 'package:my_ihma/core/constants/app_colors.dart';
import 'package:my_ihma/core/constants/urls.dart';
import 'package:my_ihma/core/utils/get_sums_fixed.dart';
import 'package:my_ihma/core/widgets/pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/html_content.dart';
import '../../../../core/widgets/appbar/silver_appbar.dart';
import '../../../../core/widgets/beautiful_error_widget.dart';
import '../../../../core/widgets/certificate_widet.dart';
import '../../../../core/widgets/info_card.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/product_widget/product_widget.dart';
import '../../../../di/di.dart';
import 'package:http/http.dart' as http;

import '../../../data/datasources/local/token_db_service.dart';

class EnhancedProductPage extends StatefulWidget {
  final String id2;

  const EnhancedProductPage({super.key, required this.id2});

  @override
  State<EnhancedProductPage> createState() => _EnhancedProductPageState();
}

class _EnhancedProductPageState extends State<EnhancedProductPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  final ValueNotifier<bool> _showFloatingTitle = ValueNotifier(false);
  final _bloc = sl<ProductBloc>();

  ProductEntity? product;
  List<ProductEntity> similarProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
    _bloc.add(ProductLoadEvent(widget.id2));
  }

  void _onScroll() {
    if (_scrollController.offset > 400 && !_showFloatingTitle.value) {
      _showFloatingTitle.value = true;
    } else if (_scrollController.offset <= 300 && _showFloatingTitle.value) {
      _showFloatingTitle.value = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProductBloc>(
        create: (context) => _bloc,
        child: BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
          if (state is ProductLoadedState) {
            product = state.product;
            similarProducts = state.similarProducts;
          }
        }, builder: (context, state) {
          if (state is ProductLoadedState) {
            return CustomScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                GlassmorphicSliverAppBar(
                  photos: state.product.photos ?? [],
                  expandedHeight: 400,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        _buildHeader(),
                        _buildContractorDetails(),
                        //subside amount
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _buildSubsidesSection(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _buildInfoCards(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _buildSupplierCard(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _buildDetailsTabs(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _buildCertificateSection(),
                        ),
                        if (similarProducts.isNotEmpty) _buildSimilarProducts(context),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is ProductLoadingState) {
            return Center(
              child: LoadingIndicator(),
            );
          }
          if (state is ProductErrorState) {
            return FluidErrorWidget(
              message: state.message,
              onRetry: () {
                _bloc.add(ProductLoadEvent(widget.id2));
              },
            );
          }

          return FluidErrorWidget(
            message: "something_went_wrong".tr(),
            onRetry: () {
              _bloc.add(ProductLoadEvent(widget.id2));
            },
          );
        }),
      ),
      floatingActionButton: ValueListenableBuilder(
        builder: (context, value, child) {
          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            offset: _showFloatingTitle.value ? const Offset(0, 0) : const Offset(0, 2),
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.greenColor,
              elevation: 2,
              onPressed: () {
                // Implement your action here
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Order Now'),
            ),
          );
        },
        valueListenable: _showFloatingTitle,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (product?.title ?? ''),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'sales_count: ${product?.salesCount ?? ""}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                  ),
                ),
                const Spacer(),
                RatingBar(
                    itemSize: 24,
                    ratingWidget: RatingWidget(
                        full: Icon(Icons.star, size: 16, color: Colors.amber),
                        half: Icon(Icons.star_half, size: 16, color: Colors.amber),
                        empty: Icon(Icons.star_border, size: 16, color: Colors.amber)),
                    onRatingUpdate: (value) {}),
                const SizedBox(
                  width: 12,
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  visualDensity: VisualDensity(vertical: -4),
                  onPressed: () {
                    // Implement favorite functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractorDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColors.gray.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gray.withValues(alpha: 0.1),
        ),
      ),
      child: Column(children: [
        Text(product?.pomClassificator ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
              fontSize: 14
                )),
        _buildSubsidyRow(label: "brand".tr(), value: product?.brand ?? "-"),
        _buildSubsidyRow(label: "country".tr(), value: product?.country ?? "-"),
        _buildSubsidyRow(label: "organization".tr(), value: product?.contractor ?? "-"),
        _buildSubsidyRow(label: "region".tr(), value: product?.contractorRegion ?? "-"),
        _buildSubsidyRow(label: "address".tr(), value: product?.contractorAddress ?? "-"),
        _buildSubsidyRow(label: "phone".tr(), value: product?.contractorPhoneNumber ?? "-"),
      ]),
    );
  }

  Widget _buildSubsidesSection() {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: AppColors.gray,
      height: 1.5,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.gray.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Text(
            'subsidy_details'.tr(),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.greenColor,
            ),
          ),
          const SizedBox(height: 12),

          // Subsidy Amount
          _buildSubsidyRow(
            label: 'subside_amount'.tr(),
            value: product?.subsidyAmount != null
                ? getSumsFixed(text: (product?.subsidyAmount ?? 0).toStringAsFixed(0))
                : '-',
            isHighlighted: true,
            textStyle: textStyle,
          ),

          // Coefficient
          _buildSubsidyRow(
            label: 'coefficient'.tr(),
            value: (product?.subsidyCoeficcient ?? 0.0).toString(),
            textStyle: textStyle,
          ),

          // Calculation Date
          _buildSubsidyRow(
            label: 'subside_calculated_date'.tr(),
            value: product?.subsidyCalculatedAt ?? '-',
            textStyle: textStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSubsidyRow({
    required String label,
    required String value,
    bool isHighlighted = false,
    TextStyle? textStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: textStyle ??
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray, height: 1.0, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: textStyle?.copyWith(
                    fontWeight: isHighlighted ? FontWeight.w600 : null,
                    color: isHighlighted ? AppColors.greenColor : null,
                    fontSize: isHighlighted ? 16 : 14,
                  ) ??
                  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12, height: 1.5),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            buildInfoCard(
              'Price Range',
              '${product?.minPrice ?? ""} - ${product?.maxPrice ?? ""} ${product?.currency ?? ""}',
              Icons.monetization_on,
              Colors.green,
            ),
            buildInfoCard(
              'Delivery',
              '${product?.minDeadlineDays ?? ""} - ${product?.maxDeadlineDays ?? ""} ${"days".tr()}',
              Icons.local_shipping,
              Colors.blue,
            ),
            buildInfoCard(
              'Warranty',
              '${product?.warrantyMonth ?? ""} ${"months".tr()}',
              Icons.security,
              Colors.orange,
            ),
            buildInfoCard(
              'Usage Duration',
              '${product?.usageDurationMonth ?? ""} ${"months".tr()}',
              Icons.access_time,
              Colors.purple,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCertificateSection() {
    return MinimalCertificateWidget(
        title: 'see_the_certificate_of_product'.tr(),
        onDownload: (onProgress) async {
          String url = "${DOMAIN}api/Pom/Product/DownloadCertificate/${product?.certificates?.first.id ?? ""}";
          String? localFilePath;
          String? title;

          try {
            final filename = url.substring(url.lastIndexOf("/") + 1);
            title = filename;

            // Create the request but don't await it yet
            final request = http.Request('GET', Uri.parse(url));
            request.headers['Authorization'] = 'Bearer ${TokenService.accessToken}';

            // Get the response as a stream
            final response = await http.Client().send(request);
            final contentLength = response.contentLength ?? 0;

            // Create file and prepare for writing
            final dir = await getApplicationDocumentsDirectory();
            final file = File('${dir.path}/$filename');
            final sink = file.openWrite();

            // Track progress
            int received = 0;
            await response.stream.listen(
              (chunk) {
                sink.add(chunk);
                received += chunk.length;
                if (contentLength > 0) {
                  onProgress.call(received / contentLength);
                }
              },
            ).asFuture(); // Convert the StreamSubscription to a Future

            await sink.close();

            localFilePath = file.path;

            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFScreen(url: "", localFilePath: localFilePath, title: title),
                ),
              );
            }
          } catch (e) {
            debugPrint('Error downloading PDF: $e');
            // Handle error appropriately
          }
        },
        onLaunch: () async {
          String url = "${DOMAIN}api/Pom/Product/DownloadCertificate/${product?.certificates?.first.id ?? ""}";

          await launchUrl(Uri.parse(url));
        });
  }

  Widget _buildSupplierCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).cardColor.withValues(alpha: 0.7),
                  Theme.of(context).cardColor.withValues(alpha: 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified,
                      color: AppColors.gray,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Supplier Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSupplierInfo(Icons.business, product?.contractor ?? ''),
                _buildSupplierInfo(Icons.person, product?.contractorDirector ?? ''),
                _buildSupplierInfo(Icons.phone, product?.contractorPhoneNumber ?? ''),
                _buildSupplierInfo(
                    Icons.location_on, '${product?.contractorRegion ?? ""}, ${product?.contractorDistrict ?? ""}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupplierInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColors.greenColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.gray,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.gray,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
              insets: const EdgeInsets.symmetric(horizontal: 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            tabAlignment: TabAlignment.fill,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
            tabs: const [
              Tab(text: 'Instructions'),
              Tab(text: 'Description'),

              // Tab(text: 'Requirements'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              // buildHtmlContent(product?.description ?? ''),
              buildHtmlContent(product?.instruction ?? ''),
              buildHtmlContent(product?.description ?? ''),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text('Similar Products${" (${similarProducts.length})".tr()}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ))),
        SizedBox(
          height: 310,
          width: MediaQuery.of(context).size.width,
          child: SimilarProductsSection(
            similarProducts: similarProducts,
            onProductTap: (product) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnhancedProductPage(
                    id2: product.id2 ?? "",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SimilarProductsSection extends StatelessWidget {
  final List<ProductEntity> similarProducts;
  final Function(ProductEntity) onProductTap;

  const SimilarProductsSection({
    super.key,
    required this.similarProducts,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (similarProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: similarProducts.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final product = similarProducts[index];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, value, child) => Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index == 0) SizedBox(width: 12),
              Container(
                height: 304,

                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(2),
                // decoration: BoxDecoration(
                //   color: Theme.of(context).cardColor,
                //   borderRadius: BorderRadius.circular(16),
                //   // border: Border.all(
                //   //   color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
                //   // ),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withValues(alpha: 0.1),
                //       blurRadius: 10,
                //       offset: const Offset(0, 5),
                //     ),
                //   ]
                // ),
                child: EnhancedProductCard(
                  product: product,
                  onTap: () {
                    if (product.id2 != null) {
                      HapticFeedback.lightImpact();
                      onProductTap(product);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

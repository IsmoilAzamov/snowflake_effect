import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/presentation/pages/product/product_page.dart';
import 'package:my_ihma/core/constants/app_colors.dart';
import 'package:my_ihma/core/widgets/beautiful_error_widget.dart';
import 'package:my_ihma/core/widgets/loading_indicator.dart';
import 'package:my_ihma/core/widgets/toasts.dart';
import '../../../../core/widgets/enhanced_searchbar.dart';
import '../../../../core/widgets/filter_dialog/filter_widget.dart';
import '../../../../core/widgets/product_widget/product_widget.dart';
import '../../../../di/di.dart';
import '../../../domain/entities/filter/filter_entity.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../bloc/market/pom_market_bloc.dart';
import '../../bloc/market/pom_market_event.dart';
import '../../bloc/market/pom_market_state.dart';

class PomMarketPage extends StatefulWidget {
  const PomMarketPage({super.key});

  @override
  State<PomMarketPage> createState() => _PomMarketPageState();
}

class _PomMarketPageState extends State<PomMarketPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<ProductEntity> _allProducts = [];
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isInitialLoadingNotifier =
      ValueNotifier<bool>(true);

  final TextEditingController _searchController =
      TextEditingController(text: "");

  final isActiveNotifier = ValueNotifier(true);

  int _currentPage = 1;
  final _bloc = sl<PomMarketBloc>();
  List<int> selectedRegions = [];
  List<int> selectedCountries = [];
  List<String> selectedBrands = [];
  int minPrice = 0;
  int maxPrice = 1000000000;

  // Add RepaintBoundary keys for each grid item
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(InitPomMarketEvent());
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialProducts() {
    _isInitialLoadingNotifier.value = true;
    _bloc.add(PomMarketLoadEvent(
      filter: FilterEntity(
        search: _searchController.text,
        page: _currentPage,
        regionIds: selectedRegions,
        brands: selectedBrands,
        countryIds: selectedCountries,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    ));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingNotifier.value) {
      _isLoadingNotifier.value = true;
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    _currentPage++;
    _bloc.add(PomMarketLoadEvent(
      filter: FilterEntity(
        page: _currentPage,
        regionIds: selectedRegions,
        brands: selectedBrands,
        countryIds: selectedCountries,
        minPrice: minPrice,
        maxPrice: maxPrice,
        search: _searchController.text,
      ),
    ));
  }

  void _addProducts(List<ProductEntity> products) {
    setState(() {
      _allProducts.addAll(products);
      // Add keys for new products
      _itemKeys.addAll(List.generate(
        products.length,
        (_) => GlobalKey(),
      ));
      _isInitialLoadingNotifier.value = false;
      _isLoadingNotifier.value = false;
    });
  }

  Widget _buildGridItem(int index) {
    return RepaintBoundary(
      key: _itemKeys[index],
      child: EnhancedProductCard(
          product: _allProducts[index],
          onTap: () {
            if (_allProducts[index].id2 != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnhancedProductPage(
                    id2: _allProducts[index].id2 ?? "",
                  ),
                ),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<PomMarketBloc, PomMarketState>(
          listener: (context, state) {
            if (state is PomMarketLoadedState) {
              _addProducts(state.products);
            } else if (state is PomMarketErrorState) {
              showErrorToast(state.message);
              _isLoadingNotifier.value = false;
              _isInitialLoadingNotifier.value = false;
            }
          },
          builder: (context, state) {
            if (state is PomMarketErrorState && _allProducts.isEmpty) {
              return FluidErrorWidget(
                message: state.message,
                onRetry: () {
                  _loadInitialProducts();
                },
              );
            }
            return Stack(
              children: [
                // Main content
                ValueListenableBuilder<bool>(
                  valueListenable: _isInitialLoadingNotifier,
                  builder: (context, isInitialLoading, _) {
                    if (isInitialLoading) {
                      return Center(
                        child: LoadingIndicator(
                          message: "${"loading".tr()}...",
                          primaryColor: Color(0xFF4DA1A9),
                          secondaryColor: Color(0xFFF7A072),
                          accentColor: Color(0xFF7E77DD),
                        ),
                      );
                    }

                    if (_allProducts.isEmpty &&
                        !_isInitialLoadingNotifier.value) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _searchController.text.isEmpty
                                ? "no_data_found".tr()
                                : "${"no_search_results_for".tr()}\"${_searchController.text}\"",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: AppColors.greenColor,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      displacement: 50,
                      onRefresh: () async {
                        _currentPage = 1;
                        _allProducts.clear();
                        _itemKeys.clear();
                        _loadInitialProducts();
                      },
                      child: CustomScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          // Add padding at the top for search bar
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 95),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 88,
                            ),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => _buildGridItem(index),
                                childCount: _allProducts.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Glassmorphic search bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 32,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withValues(alpha: 0.6),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                              width: 0.1,
                            ),
                          ),
                        ),
                        child: _searchBar(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// Don't forget to add this import at the top of your file

  @override
  void dispose() {
    _scrollController.dispose();
    _isLoadingNotifier.dispose();
    _isInitialLoadingNotifier.dispose();
    isActiveNotifier.dispose();

    super.dispose();
  }

  Widget _searchBar() {
    return EnhancedSearchBar(
      filterNotifier: isActiveNotifier,
      controller: _searchController,
      onFilterTap: () {
        //show ful screen filter bottom sheet
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: FilterWidget(
                regionIds: selectedRegions,
                countryIds: selectedCountries,
                brands: selectedBrands,
                minPrice: minPrice,
                maxPrice: maxPrice,
              ),
            );
          },
        ).then((value) {
          FocusManager.instance.primaryFocus?.unfocus();
          print("value: $value");
          if (value != null) {
            _allProducts.clear();
            selectedCountries = value["countryIds"] ?? [];
            selectedBrands = value["brands"] ?? [];
            selectedRegions = value["regionIds"] ?? [];
            minPrice = value["minPrice"] ?? 0;
            maxPrice = value["maxPrice"] ?? 1000000000;
            _loadInitialProducts();
          }
          if (selectedRegions.isEmpty &&
              selectedCountries.isEmpty &&
              selectedBrands.isEmpty &&
              minPrice == 0) {
            isActiveNotifier.value = true;
          } else {
            isActiveNotifier.value = false;
          }

          _allProducts.clear();
          _itemKeys.clear();
          _currentPage = 1;
          _loadInitialProducts();
        });
      },
      onChanged: (value) {
        _allProducts.clear();

        _loadInitialProducts();
      },
      hintText: "${'search'.tr()}...",
    );
  }
}

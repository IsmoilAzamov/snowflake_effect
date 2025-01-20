import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:my_ihma/client/presentation/bloc/filter/filter_widget_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/filter/filter_widget_event.dart';
import 'package:my_ihma/core/utils/get_sums_fixed.dart';

import '../../../client/presentation/bloc/filter/filter_widget_state.dart';
import '../../../di/di.dart';
import '../../constants/app_colors.dart';
import '../custom_button.dart';

class FilterWidget extends StatefulWidget {
  final List<int> regionIds;
  final List<int> countryIds;
  final List<String> brands;
  final int minPrice;
  final int maxPrice;

  const FilterWidget({
    super.key,
    required this.regionIds,
    required this.countryIds,
    required this.brands,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget>
    with SingleTickerProviderStateMixin {
  double minPrice = 0;
  double maxPrice = 100000000;
  final Set<TypeEntity> selectedRegions = {};
  final Set<TypeEntity> selectedCountries = {};
  final Set<TypeEntity> selectedBrands = {};
  late AnimationController _controller;
  late Animation<double> _animation;
  final _bloc = sl<FilterWidgetBloc>();
  List<TypeEntity> regions = [];
  List<TypeEntity> countries = [];
  List<TypeEntity> brands = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(FilterWidgetLoadEvent());
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        // bottomSheet: _buildApplyButton(),
        bottomSheet: _buildApplyButton(),
        body: BlocProvider<FilterWidgetBloc>(
          create: (context) => _bloc,
          child: BlocConsumer<FilterWidgetBloc, FilterWidgetState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is FilterWidgetLoadedState) {
                  regions = state.regions;
                  countries = state.countries;
                  brands = state.brands;
                  print(widget.regionIds);
                  print(widget.countryIds);

                  for (var regionId in widget.regionIds) {
                    selectedRegions.add(regions
                        .firstWhere((region) => region.value == regionId));
                  }
                  for (var countryId in widget.countryIds) {
                    selectedCountries.add(countries
                        .firstWhere((country) => country.value == countryId));
                  }
                  for (var selectedBrand in widget.brands) {
                    selectedBrands.add(brands
                        .firstWhere((brand) => brand.text == selectedBrand));
                  }
                  minPrice = widget.minPrice.toDouble();
                  maxPrice =widget.maxPrice==1000000000?100000000: widget.maxPrice.toDouble();
                  setState(() {});
                }
              },
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeader(),
                        Flexible(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPriceRangeSection(),
                                _buildFilterSection(
                                  "regions".tr(),
                                  regions,
                                  selectedRegions,
                                ),
                                _buildFilterSection(
                                  "countries".tr(),
                                  countries,
                                  selectedCountries,
                                ),
                                _buildFilterSection(
                                  "brands".tr(),
                                  brands,
                                  selectedBrands,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedRegions.clear();
                selectedCountries.clear();
                selectedBrands.clear();
                minPrice = 0;
                maxPrice = 100000000;
              });
            },
            child: Text('clear'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.blueColor, shadows: [
                  Shadow(
                    color: AppColors.blueColor,
                    offset: Offset(0, 0.2),
                    blurRadius: 0.2,
                  ),
                ])),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              await _controller.reverse();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'price_range'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Expanded(
                child: Text(
                  '${getSumsFixed(text: minPrice.toStringAsFixed(0))} - ${getSumsFixed(text: maxPrice.toStringAsFixed(0))}'
                  " ${'sum'.tr().toLowerCase()}",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.greenColor.withOpacity(0.7),
            inactiveTrackColor: Colors.grey.withOpacity(0.2),
            thumbColor: AppColors.greenColor,
            overlayColor: Theme.of(context).primaryColor.withOpacity(0.2),
            trackHeight: 4.0,
          ),
          child: RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 0,
            max: 100000000,
            onChanged: (values) {
              setState(() {
                minPrice = values.start;
                maxPrice = values.end;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
      String title, List<TypeEntity> items, Set<TypeEntity> selectedItems) {
    bool showAll = false; // Track if "Show More" is toggled

    return StatefulBuilder(
      builder: (context, setState) {
        final displayItems = showAll ? items : items.take(5).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 2,
              children: displayItems.map((item) {
                final isSelected = selectedItems.contains(item);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  child: FilterChip(
                    label: Text(
                      item.text ?? "",
                      style: TextStyle(
                          color: isSelected
                              ? AppColors.greenColor
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                          fontSize: 14),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      });
                    },
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.bgDark.withOpacity(0.8)
                            : Colors.white,
                    selectedColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.bgDark
                            : Colors.white,
                    checkmarkColor: AppColors.greenColor,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    selectedShadowColor: AppColors.greenColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.greenColor : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (items.length > 5)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                    child: Text(
                      showAll
                          ? 'show_less'.tr()
                          : "${'show_more'.tr()} (${items.length - 5})",
                      style: TextStyle(
                          color: AppColors.blueColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildApplyButton() {
    final hasSelectedFilters = true;

    return CustomButton(
      borderRadius: 8,
      backgroundColor: AppColors.lightBgBlue,
      onPressed: hasSelectedFilters
          ? () {
              List<int> regionIds =
                  selectedRegions.map((region) => region.value ?? 0).toList();
              List<int> countryIds = selectedCountries
                  .map((country) => country.value ?? 0)
                  .toList();
              List<String> brandNames =
                  selectedBrands.map((brand) => brand.text ?? "").toList();
              Navigator.pop(context, {
                'regionIds': regionIds,
                'countryIds': countryIds,
                'brands': brandNames,
                'minPrice': int.tryParse(minPrice.toStringAsFixed(0)) ?? 0,
                'maxPrice': maxPrice == 100000000
                    ? 1000000000
                    : (int.tryParse(maxPrice.toStringAsFixed(0)) ?? 0),
              });
              print("apply filter");
            }
          : () {
              Navigator.pop(context);
            },
      textColor: AppColors.blueColor,
      label: "apply_filters".tr(),
    );
  }
}

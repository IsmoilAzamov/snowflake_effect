import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/presentation/bloc/applications/applications_bloc.dart';
import 'package:my_ihma/core/widgets/beautiful_error_widget.dart';
import 'package:my_ihma/core/widgets/loading_indicator.dart';

import '../../../../core/components/skleton/banner/banner_m_skelton.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/enhanced_searchbar.dart';
import '../../../../di/di.dart';
import '../../../domain/entities/application_module/application_module_entity.dart';
import '../../../domain/entities/application_type/application_type_entity.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../bloc/applications/applications_event.dart';
import '../../bloc/applications/applications_state.dart';

class ApplicationsPage extends StatefulWidget {
  final List<ApplicationTypeEntity> types;

  const ApplicationsPage({
    super.key,
    required this.types,
  });

  @override
  State<ApplicationsPage> createState() => _ApplicationCarouselPageState();
}

class _ApplicationCarouselPageState extends State<ApplicationsPage> {
  int _currentModuleIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  final ScrollController _scrollController = ScrollController();
  List<ApplicationModuleEntity> modules = [];
  final _bloc = sl<ApplicationsBloc>();
  final TextEditingController _searchController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _bloc.add(InitApplicationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        shadowColor: AppColors.greenColor.withValues(alpha: 0.2),
        colorScheme: Theme.of(context).brightness == Brightness.dark
            ? ColorScheme.dark(
                primary: Colors.transparent,
                secondary: Colors.amber[400]!,
              )
            : ColorScheme.light(
                primary: Colors.transparent,
                secondary: Colors.amber[100]!,
              ),
      ),
      child: Scaffold(
        body: BlocConsumer<ApplicationsBloc, ApplicationsState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ApplicationsLoadedState) {
              modules = state.products;
              // modules.addAll(modules);
            }
          },
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildStateWidget(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStateWidget(ApplicationsState state) {
    if (state is ApplicationsLoadedState) {
      return _loadedUI();
    } else if (state is ApplicationsLoadingState) {
      return LoadingIndicator();
    }
    return _buildErrorState(state);
  }

  Widget _buildErrorState(ApplicationsState state) {
    return FluidErrorWidget(
      message: state is ApplicationsErrorState ? state.message : "something_went_wrong".tr(),
      onRetry: () => _bloc.add(InitApplicationsEvent()),
    );
  }

  Widget _loadedUI() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildModuleCarousel(),
              const SizedBox(height: 20),
              _buildModuleIndicator(),
              const SizedBox(height: 20),
              if (modules.isNotEmpty && modules[_currentModuleIndex].id != null)
                TypeListWidget(
                  id: modules[_currentModuleIndex].id!,
                  title: modules[_currentModuleIndex].shortName,
                  key: Key(modules[_currentModuleIndex].id!.toString()),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: false,
      stretch: false,
      title: Column(
        children: [
          _searchBar(),
        ],
      ),

      backgroundColor: Colors.black.withValues(alpha: 0.1),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildAnimatedBackground(),
            _buildOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCarousel() {
    if (modules.isEmpty) {
      return _buildEmptyState();
    }

    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: modules.length,
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        autoPlay: true,
        enableInfiniteScroll: modules.length > 1,
        onPageChanged: (index, reason) {
          setState(() {
            _currentModuleIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final module = modules[index];
        final isActive = module.state?.toLowerCase() == 'active';

        return ModuleCard(
          module: module,
          isActive: isActive,
          isSelected: index == _currentModuleIndex,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.apps_outlined,
            size: 64,
            color: Colors.green[200],
          ),
          const SizedBox(height: 16),
          Text(
            'no_data_found'.tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fade().scale();
  }

  Widget _buildModuleIndicator() {
    if (modules.length <= 1) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: modules.asMap().entries.map((entry) {
        final isSelected = entry.key == _currentModuleIndex;
        return GestureDetector(
            onTap: () => _carouselController.animateToPage(entry.key),
            child: AnimatedContainer(
              width: isSelected ? 24 : 12,
              curve: Curves.fastOutSlowIn,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isSelected ? AppColors.greenColor : Colors.grey[700]!,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.green[400]!.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              duration: const Duration(milliseconds: 300),
            ));
      }).toList(),
    );
  }

  Widget _searchBar() {
    return EnhancedSearchBar(
      filterNotifier: null,
      controller: _searchController,
      onChanged: (value) {},
      hintText: "${'search'.tr()}...",
      onFilterTap: null,
    );
  }
}

class ModuleCard extends StatefulWidget {
  final ApplicationModuleEntity module;
  final bool isActive;
  final bool isSelected;

  const ModuleCard({
    required this.module,
    required this.isActive,
    required this.isSelected,
    super.key,
  });

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 3),
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered || widget.isSelected ? 1.02 : 1.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: widget.isSelected
                ? AppColors.greenColor.withValues(alpha: 0.3)
                : AppColors.greenColor.withValues(alpha: 0.1),
            // boxShadow: [
            //   BoxShadow(
            //     color:
            //         widget.isActive ? Colors.green[400]!.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.2),
            //     blurRadius: _isHovered ? 20 : 12,
            //     offset: const Offset(0, 8),
            //   ),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: const Duration(seconds: 3),
          color: Colors.white.withValues(alpha: 0.1),
        );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(height: 12),
        Text(
          widget.module.shortName ?? 'N/A',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Code: ${widget.module.code ?? 'N/A'}',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.9),
            Colors.white.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: widget.isActive ? Colors.green[100] : Colors.grey[200],
        child: Text(
          widget.module.shortName?.substring(0, 1).toUpperCase() ?? 'M',
          style: TextStyle(
            color: widget.isActive ? Colors.green[700] : Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class TypeListWidget extends StatelessWidget {
  final int id;
  final String? title;

  const TypeListWidget({
    super.key,
    required this.id,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            spacing: 8,
            children: [
              Text(
                title.toString(),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              AnimatedContainer(duration: const Duration(milliseconds: 200), child: BannerMSkelton()).animate().fade(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 1000),
                  ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildAnimatedBackground() {
  return Stack(
    children: [
      ...List.generate(20, (index) {
        return Positioned(
          left: (index * 50).toDouble(),
          top: (index * 20).toDouble(),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.green[400]!.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .scale(
              duration: Duration(seconds: 2 + index),
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.5, 1.5),
            )
            .fadeIn(duration: const Duration(milliseconds: 500));
      }),
    ],
  );
}

Widget _buildOverlay() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF1A1A2E).withValues(alpha: 0.0),
          ],
        ),
      ),
    ),
  );
}

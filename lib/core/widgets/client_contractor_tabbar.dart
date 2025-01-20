import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_colors.dart';

class ClientContractorTabBar extends StatefulWidget {
  final Function(int)? onTabChanged;
  final double height;

  const ClientContractorTabBar({
    super.key,
    this.onTabChanged,
    this.height = 45,
  });

  @override
  State<ClientContractorTabBar> createState() => _ClientContractorTabBarState();
}

class _ClientContractorTabBarState extends State<ClientContractorTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<TabItem> _tabs = [
    TabItem(
      title: 'user'.tr(),
      icon: FontAwesomeIcons.user,
      activeIcon:FontAwesomeIcons.solidUser,
    ),
    TabItem(
      title: 'contractor'.tr(),
      icon: FontAwesomeIcons.businessTime,
      activeIcon: FontAwesomeIcons.businessTime,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: widget.height,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.bgDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColors.greenColor,
          ),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return states.contains(WidgetState.focused) ? AppColors.blueColor : Colors.transparent;
            },
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white60 : AppColors.gray,
          tabs: _tabs.map((tab) => _buildTab(tab)).toList(),
        ),
      ),
    );
  }

  Widget _buildTab(TabItem tab) {
    return Tab(
      height: widget.height - 16,
      child: AnimatedBuilder(
        animation: _tabController,
        builder: (context, child) {
          final isSelected = _tabs.indexOf(tab) == _tabController.index;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? tab.activeIcon : tab.icon,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(tab.title),
            ],
          );
        },
      ),
    );
  }
}

class TabItem {
  final String title;
  final IconData icon;
  final IconData activeIcon;

  const TabItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

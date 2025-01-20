import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';
import 'package:my_ihma/client/domain/entities/application_type/application_type_entity.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/toasts.dart';
import '../../../../di/di.dart';
import '../../bloc/home/home_bloc.dart';
import '../applications/applications_page.dart';
import '../login/login_page.dart';
import '../market/pom_market.dart';

final homeBloc = sl<HomeBloc>();

class HomePage extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const HomePage({super.key, required this.onThemeToggle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Widget> pages = [LoginPage()];

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    pages.addAll([
    ApplicationsPage(types: [
      ApplicationTypeEntity(id: 0, fullName: "Checking values 1", shortName: "Opps you are perfect 1", code: "01", stateId: 0, state: "First state", orderCode: "01", modifiedAt: "01.01.2001", processingPeriodInDays: 1, module: "Module 1", moduleCode: "01",createdAt: "01.01.2001",isGroup: true, isUniversal: true, applicationGroupId: 1, hasApplication: true, parentId: 0),
      ApplicationTypeEntity(id: 0, fullName: "Checking values 1", shortName: "Opps you are perfect 1", code: "01", stateId: 0, state: "First state", orderCode: "01", modifiedAt: "01.01.2001", processingPeriodInDays: 1, module: "Module 1", moduleCode: "01",createdAt: "01.01.2001",isGroup: true, isUniversal: true, applicationGroupId: 1, hasApplication: true, parentId: 0),
      ApplicationTypeEntity(id: 0, fullName: "Checking values 1", shortName: "Opps you are perfect 1", code: "01", stateId: 0, state: "First state", orderCode: "01", modifiedAt: "01.01.2001", processingPeriodInDays: 1, module: "Module 1", moduleCode: "01",createdAt: "01.01.2001",isGroup: true, isUniversal: true, applicationGroupId: 1, hasApplication: true, parentId: 0),
      ApplicationTypeEntity(id: 0, fullName: "Checking values 1", shortName: "Opps you are perfect 1", code: "01", stateId: 0, state: "First state", orderCode: "01", modifiedAt: "01.01.2001", processingPeriodInDays: 1, module: "Module 1", moduleCode: "01",createdAt: "01.01.2001",isGroup: true, isUniversal: true, applicationGroupId: 1, hasApplication: true, parentId: 0),
    ],),
      PomMarketPage(),
      Container(color: Colors.blue)
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          systemNavigationBarColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.bgDark.withValues(alpha: 1)
                  : Color(0xffF5F5F5),
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark),
    );

    return BlocBuilder<HomeBloc, int>(
        bloc: homeBloc,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, String? result) async {
              print(state);
              if (didPop) {
                print("didPop");
                return;
              }
              if (state == 0) {
                final bool shouldPop = await onWillPop();
                if (shouldPop) {
                  SystemNavigator.pop();
                }
              } else {
                setState(() {
                  homeBloc.add(0);
                });
              }
            },
            child: Scaffold(
              body: IndexedStack(
                index: state,
                children: pages,
              ),
              bottomSheet: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                      height: 80,
                      transformAlignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.transparent
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border(
                              top: BorderSide(
                                  color: AppColors.borderGray
                                      .withValues(alpha: 0.5),
                                  width: .5))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      width: double.infinity,
                      child: MediaQuery.removeViewInsets(
                        removeRight: true,
                        removeLeft: true,
                        removeTop: true,
                        removeBottom: true,
                        context: context,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FooterItem(
                                  selected: state == 0,
                                  state: state,
                                  icon: FontAwesomeIcons.house,
                                  title: "main".tr(),
                                  onTap: () {
                                    homeBloc.add(0);
                                    // showSuccessBottomSheet("login_success".tr());
                                  },
                                ),
                                FooterItem(
                                  selected: state == 1,
                                  state: state,
                                  icon: FontAwesomeIcons.toolbox,
                                  title: "my_services".tr(),
                                  onTap: () {
                                    homeBloc.add(1);
                                  },
                                ),
                                FooterItem(
                                  selected: state == 2,
                                  state: state,
                                  icon: FontAwesomeIcons.bagShopping,
                                  title: "pom_market".tr(),
                                  onTap: () {
                                    homeBloc.add(2);
                                  },
                                ),
                                FooterItem(
                                  selected: state == 3,
                                  state: state,
                                  icon: FontAwesomeIcons.solidUser,
                                  title: "profile".tr(),
                                  onTap: () {
                                    homeBloc.add(3);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
        });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showSimpleToast(
        'double_tap_to_exit'.tr(),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class FooterItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  final int state;

  const FooterItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.selected,
    required this.state,
  });

  @override
  State<FooterItem> createState() => _FooterItemState();
}

class _FooterItemState extends State<FooterItem> {
  //listen to language changes from box.get("lang");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(widget.icon, // Home icon
                size: 24,
                color: Theme.of(context).brightness == Brightness.dark
                    ? (widget.selected ? Colors.green : Colors.white)
                    : (widget.selected ? Colors.green : AppColors.gray)),
            const SizedBox(height: 4),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.25),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? (widget.selected ? Colors.white : Colors.white70)
                        : (widget.selected
                            ? Color(0xff505050)
                            : AppColors.gray),
                    fontWeight:
                        widget.selected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

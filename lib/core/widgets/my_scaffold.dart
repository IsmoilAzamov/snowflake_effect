import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../main.dart';

class MyScaffold extends StatefulWidget {
  final AppBar? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;

  const MyScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
  });

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {


  @override
  void initState() {
    super.initState();
    // Initialize the subscription
  }



  @override
  Widget build(BuildContext context) {
    bool isDark = prefs.getString("theme") != 'light';
    // print("=========================Theme: ${prefs.getString("theme")} --=========================");
    return SafeArea(
      child: Container( // Wrap the entire Scaffold with a Container
        color: isDark ? AppColors.bgDark : AppColors.lightBgBlue, // Ensure no black is visible
        child: Scaffold(
          key: widget.key,
          backgroundColor: Colors.transparent, // Set to transparent since the Container handles it
          appBar: widget.appBar,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  isDark ? 'assets/background_pattern.png' : 'assets/background_pattern_light.png',
                  fit: BoxFit.fill,
                ),
              ),
              widget.body ?? Container(),
            ],
          ),
          floatingActionButton: widget.floatingActionButton,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
        ),
      ),
    );
  }

}

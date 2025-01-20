import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.white,
  primarySwatch: Colors.green,
  fontFamily: "Montserrat",
  primaryColorDark: AppColors.greenColor,
  primaryColorLight: AppColors.greenColor,
  primaryIconTheme: const IconThemeData(color: AppColors.greenColor),
  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.greenColor,
    foregroundColor: Colors.white, // Set foreground color to white
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.dark,

  ),

  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),


  // Button Theme
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.greenColor,
    textTheme: ButtonTextTheme.normal,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.greenColor,
    onPrimary: Colors.white,
    secondary: AppColors.gray,
    onSecondary: Colors.white,
    error: AppColors.redColor,
    onError: Colors.white,
    onSurface: AppColors.titleColor,
    surface: Colors.white,
  ),

  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.gray),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.lightBgBlue, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.gray, width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.redColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.redColor),
    ),
    errorStyle: TextStyle(color: AppColors.redColor, fontSize: 12),
    filled: true,
    fillColor: Colors.white,
    floatingLabelStyle: TextStyle(color: AppColors.blueColor),
    hintStyle: TextStyle(color: AppColors.gray, fontSize: 16),
    labelStyle: TextStyle(color: AppColors.gray, fontSize: 16),
  ),
  hintColor: AppColors.gray,
  // Text Theme
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.blueColor,
      fontSize: 45,
    ),
    displayMedium: TextStyle(
      color: AppColors.blueColor,
      fontSize: 40,
    ),
    displaySmall: TextStyle(
      color: AppColors.blueColor,
      fontSize: 35,
    ),
    headlineLarge: TextStyle(
      color: AppColors.bgDark,
      fontSize: 36,
    ),
    headlineMedium: TextStyle(
      color: AppColors.bgDark,
      fontSize: 28,
    ),
    headlineSmall: TextStyle(
      color: AppColors.bgDark,
      fontSize: 24,
    ),
    titleLarge: TextStyle(
      color: AppColors.blueColor,
      fontSize: 20,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: AppColors.bgDark,
      fontSize: 16,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      color: AppColors.bgDark,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16, letterSpacing: 0.5),
    bodyMedium: TextStyle(color: Colors.black87, fontSize: 16, letterSpacing: 0.25),
    bodySmall: TextStyle(color: Colors.black87, fontSize: 14, letterSpacing: 0.4),
    labelLarge: TextStyle(color: Colors.black87, fontSize: 14, decoration: TextDecoration.none, letterSpacing: 0.1),
    labelMedium: TextStyle(color: AppColors.blueColor, fontSize: 12, letterSpacing: 0.5),
    labelSmall: TextStyle(color: AppColors.blueColor, fontSize: 11, letterSpacing: 0.5),
  ),

  scaffoldBackgroundColor: Color(0xffFAFAFF),
  cardColor: Colors.white,
  canvasColor: Colors.white,
  dividerColor: Colors.grey,

  // Snackbar Theme
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(color: Colors.white),
  ),

  // Dialog Theme
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black87),
    contentTextStyle: TextStyle(color: Colors.black87),
  ),

  // Bottom Sheet Theme
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
  ),

  // TabBar Theme
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Colors.grey,
  ),

  // Tooltip Theme
  tooltipTheme: const TooltipThemeData(
    textStyle: TextStyle(color: Colors.white),
  ),

  // PopupMenu Theme
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
  ),

  // Time Picker Theme
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: Colors.white,
  ),

  // TextButton Theme
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.blueColor),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),

  // ElevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.blueColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevation: WidgetStateProperty.all(2.0),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  ),

  // OutlinedButton Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.blueColor),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.all(
        BorderSide(color: AppColors.blueColor),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.bgDark,
  primarySwatch: Colors.green,
  primaryColorDark: AppColors.bgDark,
  primaryColorLight: AppColors.lightBlue,

  fontFamily: "Montserrat",
  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.bgDark,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // Button Theme
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.blueColor,
    textTheme: ButtonTextTheme.normal,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    selectedItemColor: AppColors.blueColor,
    selectedIconTheme: IconThemeData(color: AppColors.blueColor),
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(color: AppColors.blueColor),
    backgroundColor: Color(0xff001029),
  ),

  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
  ),
  // Color Scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    secondary: AppColors.secondaryColor,
    error: Colors.red,
    onPrimary: Colors.black87,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
    surface: Colors.black87,
  ),

  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
    ),
    hintStyle: const TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.transparent,
    errorStyle: TextStyle(color: AppColors.redColor, fontSize: 12),
    labelStyle: const TextStyle(color: Colors.grey),
    helperStyle: const TextStyle(color: Colors.grey),
    floatingLabelStyle: const TextStyle(color: Colors.black87),
    prefixStyle: const TextStyle(color: Colors.white),
  ),

  // Text Theme
  indicatorColor: AppColors.greenColor,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 45,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 40,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 35,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 36,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 28,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.5),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.25),
    bodySmall: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.4),
    labelLarge: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none, letterSpacing: 0.1),
    labelMedium: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 0.5),
    labelSmall: TextStyle(color: Colors.white, fontSize: 11, letterSpacing: 0.5),
  ),

  // Icon Theme
  scaffoldBackgroundColor: AppColors.bgDark,
  cardColor: Colors.black87,
  canvasColor: Colors.black87,
  dividerColor: Colors.grey,

  // Bottom Sheet Theme
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.bgDark,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    modalBackgroundColor: AppColors.bgDark,
  ),

  // TabBar Theme
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: Colors.grey,
  ),

  // Tooltip Theme
  tooltipTheme: const TooltipThemeData(
    textStyle: TextStyle(color: Colors.white),
  ),

  // PopupMenu Theme
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.black87,
  ),

  // Time Picker Theme
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: Colors.black87,
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.blueColor),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),

  // ElevatedButton Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      foregroundColor: WidgetStateProperty.all(AppColors.bgDark),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevation: WidgetStateProperty.all(2.0),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.bgDark,
        ),
      ),
    ),
  ),

  // OutlinedButton Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColors.blueColor),
      backgroundColor: WidgetStateProperty.all(Colors.black87),
      side: WidgetStateProperty.all(
        BorderSide(color: AppColors.blueColor),
      ),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),
);

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const curve = Curves.easeInOut;
    var tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: curve));
    var slideAnimation = animation.drive(tween);

    return SlideTransition(
      position: slideAnimation,
      child: child,
    );
  }
}

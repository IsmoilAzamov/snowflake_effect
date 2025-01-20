import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../main.dart';

// var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(prefs.getString("theme") != 'light' ? DarkTheme() : LightTheme()) {
    on<ThemeEvent>((event, emit) {
      // print(event);
      // print(ThemeEvent);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: event is ToggleLight ? const Color(0xffFFFFFF) : AppColors.bgDark,
        statusBarIconBrightness: event is ToggleLight ? Brightness.dark : Brightness.light,
        statusBarBrightness: event is ToggleLight ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: event is ToggleLight ? Colors.white : AppColors.bgDark,
        systemNavigationBarIconBrightness: event is ToggleLight ? Brightness.dark : Brightness.light,
      ));
      if (event is ToggleDark) {
        prefs.setString('theme', 'dark');
        emit(DarkTheme());
        return;
      }
      if (event is ToggleLight) {
        prefs.setString('theme', 'light');
        emit(LightTheme());
        return;
      }
    });
  }
}

sealed class ThemeState {}

class DarkTheme extends ThemeState {}

class LightTheme extends ThemeState {}

sealed class ThemeEvent {}

class ToggleLight extends ThemeEvent {}

class ToggleDark extends ThemeEvent {}

// setStatusBarVisibility() {
//   ThemeEvent event = themeData == lightTheme ? ThemeEvent.toggleDark : ThemeEvent.toggleLight;
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: event==ThemeEvent.toggleLight ?getScaffoldBgColor() : Colors.black,
//     statusBarIconBrightness: event==ThemeEvent.toggleLight ? Brightness.dark : Brightness.light,
//     statusBarBrightness: event==ThemeEvent.toggleLight  ? Brightness.light : Brightness.dark,
//     systemNavigationBarColor: event==ThemeEvent.toggleLight  ? Colors.white : Colors.black,
//     systemNavigationBarIconBrightness: event==ThemeEvent.toggleLight ? Brightness.dark : Brightness.light,
//   ));
// }
//
//
// Color getScaffoldBgColor() {
//   return themeData == lightTheme ? Colors.white : Colors.black;
// }

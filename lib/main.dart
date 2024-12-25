import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snow_effect/seasonal_effect.dart';

import 'home_page.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue.shade800,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey.shade900,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          IgnorePointer(
              child: seasonalEffectWidget(Range(0.1, 4), context: context)),
          HomePage(onThemeToggle: _toggleTheme),
          IgnorePointer(
              child: seasonalEffectWidget(Range(4, 10), context: context)),
        ],
      ),
    );
  }
}

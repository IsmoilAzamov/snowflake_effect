import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';
import 'package:my_ihma/client/domain/entities/application_type/application_type_entity.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:my_ihma/client/presentation/pages/login/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'client/presentation/bloc/theme/theme_bloc.dart';
import 'client/presentation/pages/home/home_page.dart';
import 'client/presentation/pages/login/login_page.dart';
import 'core/constants/app_colors.dart';
import 'core/theme/theme_data.dart';
import 'di/di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late SharedPreferences prefs;
const String APP_VERSION = '0.0.1';
final themeBloc = ThemeBloc();
late Box box;




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  registerAdapters();
  await EasyLocalization.ensureInitialized();
  box = await Hive.openBox('myIhma');
  await initializeDependencies();
  prefs = await SharedPreferences.getInstance();

  var myTheme = prefs.getString("theme") != "light" ? ToggleDark() : ToggleLight();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: myTheme is ToggleLight ? Brightness.dark : Brightness.light,
    statusBarBrightness: myTheme is ToggleLight ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: myTheme is ToggleLight ? Colors.white : AppColors.bgDark,
    systemNavigationBarIconBrightness: myTheme is ToggleLight ? Brightness.dark : Brightness.light,
  ));
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'uz', countryCode: "UZ", scriptCode: "Cyrl"), // Uzbek in Cyrillic script
        Locale.fromSubtags(languageCode: 'uz', countryCode: "UZ", scriptCode: "Latn"), // Uzbek in Latin script
        Locale.fromSubtags(languageCode: 'kk', countryCode: "UZ", scriptCode: "Cyrl"), // Karakalpak in Cyrillic script
        Locale.fromSubtags(languageCode: 'ru', countryCode: "RU"), // Russian
      ],
      startLocale: const Locale.fromSubtags(languageCode: 'uz', countryCode: "UZ", scriptCode: "Latn"),
      path: 'assets/translations',
      fallbackLocale: const Locale.fromSubtags(languageCode: 'uz', countryCode: "UZ", scriptCode: "Latn"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void _toggleTheme(bool isDarkMode) {
    prefs.setString("theme", isDarkMode ? "dark" : "light");
    setState(() {
    });
  }
  bool isDark = prefs.getString("theme") != 'light';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => themeBloc,
      child: BlocConsumer<ThemeBloc, ThemeState>(
          bloc: themeBloc,
          listener: (context, state) {
            setState(() {
              isDark = prefs.getString("theme") != 'light';
              // print("-------------------------------------RunApp theme: ${prefs.getString("theme")}------------------------------------");
            });
          },
          builder: (context, state) {
            // writeLogsToStorage("RunApp theme: ${prefs.getString("theme")}");
            return ToastificationWrapper(
              child: MaterialApp(
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                darkTheme: darkTheme,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                title: 'My IHMA',
                theme: isDark ? darkTheme : lightTheme,

                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                routes: {
                  '/login': (context) => const LoginPage(),
                  '/start': (context) => const LoginPage(),
                  '/register': (context) => const RegisterPage(),
                  '/home': (context) =>  HomePage(onThemeToggle: _toggleTheme,),

                },
                home: HomePage(onThemeToggle: _toggleTheme,),
                color: isDark ? AppColors.bgDark : AppColors.blueColor,
              ),
            );
          }),
    );
  }
}





void registerAdapters() {
  Hive.registerAdapter(TypeEntityAdapter());
  Hive.registerAdapter(ApplicationModuleEntityAdapter());
  Hive.registerAdapter(ApplicationTypeEntityAdapter());
}
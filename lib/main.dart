import 'package:flutter/material.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/features/navigation/main_Screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

import 'core/services/preferences_manager.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  ThemeController().init();
  String? name = PreferencesManager().getString("name");

  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: name == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}

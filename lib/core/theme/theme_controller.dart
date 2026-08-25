import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool theme = PreferencesManager().getBool("theme") ?? false;
    themeNotifier.value = theme ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.light) {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool("theme", true);
    } else {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool("theme", false);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}

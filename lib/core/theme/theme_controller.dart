import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool theme = PreferencesManager().getBool(StorageKey.theme) ?? false;
    themeNotifier.value = theme ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.light) {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool(StorageKey.theme, true);
    } else {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(StorageKey.theme, false);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}

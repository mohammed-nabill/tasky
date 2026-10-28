import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF6F7F9),
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
    tertiary: Color(0xFF3A4640),
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFF6F7F9),
    foregroundColor: const Color(0xFF161F1B),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.sp20,
      color: Color(0xFF161F1B),
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Color(0xFFFFFFFF);
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFFFFCFC);
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
      minimumSize: Size.fromHeight(AppSizes.h40),
      textStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
    ),
  ),

  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.sp28,
      color: Color(0xFF161F1B),
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.sp24,
      color: Color(0xFF161F1B),
    ),
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(),
    labelMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
    ),
    // for done task
    titleMedium: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(color: Colors.black, fontSize: AppSizes.sp24),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSizes.r4),
    ),
    side: BorderSide(width: AppSizes.w2, color: Color(0xFFD1DAD6)),
  ),

  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: AppSizes.sp16,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.lightBlueAccent,
    selectionHandleColor: Colors.lightBlueAccent,
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF14A662),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: AppSizes.sp20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
  ),
);

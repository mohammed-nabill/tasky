import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF181818),
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFFFFCFC),
    tertiary: Color(0xFFC6C6C6),
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF181818),
    foregroundColor: const Color(0xFFFFFCFC),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xFFFFFCFC),
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
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),

  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      color: Color(0xFFFFFFFF),
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Color(0xFFFFFCFC),
    ),
    displayLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0XFFA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    labelLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(color: Colors.white, fontSize: 24),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF6D6D6D),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
    side: BorderSide(width: 2, color: Color(0xFF6E6E6E)),
  ),

  iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.lightBlueAccent,
    selectionHandleColor: Colors.lightBlueAccent,
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
    ),
    shadowColor: Color(0xFF15B86C),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(width: 1, color: Color(0xFF15B86C)),
    ),
  ),
);

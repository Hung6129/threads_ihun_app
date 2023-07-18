import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData dark = ThemeData(
    iconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white),
        ),
        iconColor: MaterialStateProperty.all(
          Colors.white,
        ),
      ),
    ),
    dialogBackgroundColor: Colors.black,
    colorSchemeSeed: Colors.black,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );

  static ThemeData light = ThemeData(
    colorSchemeSeed: Colors.white,
    useMaterial3: true,
    brightness: Brightness.light,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.black),
        ),
        iconColor: MaterialStateProperty.all(
          Colors.black,
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    ),
  );
}

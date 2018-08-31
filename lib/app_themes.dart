import 'package:flutter/material.dart';

final AppTheme lightAppTheme = AppTheme._('Light', _buildLightTheme());
final AppTheme darkAppTheme = AppTheme._('Dark', _buildDarkTheme());

class AppTheme {
  const AppTheme._(this.name, this.data);

  final String name;
  final ThemeData data;
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: 'GoogleSans',
    ),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = const Color(0xFF0175c2);
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    splashFactory: InkSplash.splashFactory,
    accentColor: const Color(0xFF13B9FD),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

ThemeData _buildDarkTheme() {
  const Color primaryColor = const Color(0xFF0175c2);
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    splashFactory: InkSplash.splashFactory,
    accentColor: const Color(0xFF13B9FD),
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}
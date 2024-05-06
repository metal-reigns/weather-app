import 'package:flutter/material.dart';
import 'package:weather_app/services/theme/app_colors.dart';

class AppTheme with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeMode get themeMode {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData _theme({required AppColors appColors}) => ThemeData(
        brightness: _isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.indigo,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: appColors.scaffold,
        dividerColor: appColors.dividerColor,
        primaryColorLight: appColors.primaryLight,
        errorColor: appColors.error,
        textTheme: _textTheme(appColors),
        iconTheme: IconThemeData(color: appColors.accentForeground),
        appBarTheme: _appBarTheme(appColors),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: appColors.foreground),
        outlinedButtonTheme: _outlinedButtonTheme(appColors),
      );

  TextTheme _textTheme(AppColors appColors) => TextTheme(
        bodySmall: TextStyle(color: appColors.foreground, fontSize: 13),
        bodyMedium: TextStyle(color: appColors.foreground, fontSize: 16),
        bodyLarge: TextStyle(color: appColors.foreground, fontSize: 18),
      );

  AppBarTheme _appBarTheme(AppColors appColors) => AppBarTheme(
        backgroundColor: appColors.appBarBackground,
        foregroundColor: appColors.accentForeground,
        iconTheme: IconThemeData(color: appColors.accentForeground),
        elevation: 3,
      );

  OutlinedButtonThemeData _outlinedButtonTheme(AppColors appColors) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color?>(appColors.foreground),
            side: MaterialStateProperty.all<BorderSide?>(
                BorderSide(color: appColors.foreground))),
      );

  ThemeData get light => _theme(appColors: ColorsLight());
  ThemeData get dark => _theme(appColors: ColorsDark());

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

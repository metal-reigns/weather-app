import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/theme/app_theme.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Provider.of<AppTheme>(context);
    bool isLight = appTheme.themeMode == ThemeMode.light;
    return IconButton(
      icon: Icon(isLight ? Icons.wb_sunny : Icons.brightness_2),
      onPressed: () => appTheme.toggleTheme(),
    );
  }
}

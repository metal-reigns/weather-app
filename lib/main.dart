import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/models/weather_provider.dart';
import 'package:weather_app/services/theme/app_theme.dart';
import 'package:weather_app/presentation/widgets/home_screen_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (BuildContext context, AppTheme appTheme, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme.light,
          darkTheme: appTheme.dark,
          themeMode: appTheme.themeMode,
          home: const HomeScreenWidget(),
        );
      },
    );
  }
}

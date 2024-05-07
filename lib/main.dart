import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/weather_provider.dart';
import 'package:weather_app/i18n/translations.g.dart';
import 'package:weather_app/services/theme/app_theme.dart';
import 'package:weather_app/presentation/widgets/home_screen/home_screen_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: Consumer<AppTheme>(
        builder: (BuildContext context, AppTheme appTheme, Widget? child) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            theme: appTheme.light,
            darkTheme: appTheme.dark,
            themeMode: appTheme.themeMode,
            home: const HomeScreenWidget(),
          );
        },
      ),
    );
  }
}

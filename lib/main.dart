import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_provider.dart';
import 'package:weather_app/ui/home_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreenWidget(),
      ),
    );
  }
}

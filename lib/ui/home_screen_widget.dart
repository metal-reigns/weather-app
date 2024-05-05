import 'package:flutter/material.dart';
import 'package:weather_app/ui/location_dialog_settings_widget.dart';
import 'package:weather_app/ui/weather_list_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Column(
        children: [
          Expanded(child: WeatherList()),
          // MainWeatherScreen(),
          FloatingActionButton(
            onPressed: () => showLocationDialog(context),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  void showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LocationDialog(),
        );
      },
    );
  }
}

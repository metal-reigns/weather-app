import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/models/weather_provider.dart';
import 'package:weather_app/presentation/widgets/card/expansion_tile_widget.dart';
import 'package:weather_app/presentation/widgets/card/weather_card_widget.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return ListView.builder(
      itemCount: weatherProvider.weathers.length,
      itemBuilder: (context, index) {
        final weather = weatherProvider.weathers[index];
        return Column(
          children: [
            WeatherCardWidget(weather: weather),
            ExpansionTileWidget(
                dailyWeatherList: weather.dailyForecasts,
                background: weather.mainDescription),
          ],
        );
      },
    );
  }
}

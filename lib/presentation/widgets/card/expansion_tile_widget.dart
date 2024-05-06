import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/theme/app_colors.dart';
import 'package:weather_app/configuration/configuration.dart';
import 'package:weather_app/domain/entity/daily_weather.dart';

class ExpansionTileWidget extends StatelessWidget {
  final List<DailyWeather> dailyWeatherList;
  final String background;

  const ExpansionTileWidget(
      {super.key, required this.dailyWeatherList, required this.background});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _getWeatherBackground(background);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var isMobile = constraints.maxWidth < 600;
        double cardWidth = isMobile ? constraints.maxWidth : 385;
        Widget titleWidget = dailyWeatherList.isNotEmpty
            ? buildTitleWidget(dailyWeatherList.first)
            : const Text("No data available", style: TextStyle(fontSize: 16));

        return Container(
          width: cardWidth,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(20)),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 10),
            title: titleWidget,
            trailing: const Icon(Icons.arrow_circle_down, color: Colors.white),
            children: dailyWeatherList
                .map((dailyWeather) => buildWeatherRow(dailyWeather))
                .toList(),
          ),
        );
      },
    );
  }

  Widget buildTitleWidget(DailyWeather weather) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "${DateFormat('EEE dd').format(weather.dateTime)}, ${weather.dateTime.hour}:00 - ${weather.temperature.toStringAsFixed(1)}°C, ${weather.description}",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildWeatherRow(DailyWeather dailyWeather) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '${DateFormat('EEE dd').format(dailyWeather.dateTime)}, ${dailyWeather.dateTime.hour}:00',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              "${dailyWeather.temperature.toStringAsFixed(1)}°C,   ${dailyWeather.description}",
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: Image.network(
                '${Configuration.openWeather.imageUrl}/${dailyWeather.icon}.png'),
          ),
        ],
      ),
    );
  }

  Color _getWeatherBackground(String description) {
    switch (description.toLowerCase()) {
      case 'clear':
        return AppColors.clearSkyColor;
      case 'thunderstorm':
        return AppColors.thunderColor;
      case 'clouds':
        return AppColors.cloudsColor;
      case 'rain':
        return AppColors.rainColor;
      case 'snow':
        return AppColors.snowColor;
      case 'mist':
        return AppColors.mistColor;
      default:
        return AppColors.mistColor; // Default color if no match found
    }
  }
}

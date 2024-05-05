// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:weather_app/ui/weather_card_widget.dart';
// import 'package:weather_app/weather_provider.dart';
//
// class WeatherList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final weatherProvider = Provider.of<WeatherProvider>(context);
//     return ListView.builder(
//       itemCount: weatherProvider.weathers.length,
//       itemBuilder: (context, index) {
//         final weather = weatherProvider.weathers[index];
//         return WeatherCard(weather: weather);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/entity/current_weather.dart';
import 'package:weather_app/weather_provider.dart';

class WeatherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем доступ к провайдеру погоды
    var weatherProvider = Provider.of<WeatherProvider>(context);

    return ListView.builder(
      itemCount: weatherProvider.weathers.length,
      itemBuilder: (context, index) {
        // Получаем объект CurrentWeather для текущей позиции
        CurrentWeather currentWeather = weatherProvider.weathers[index];

        return ExpansionTile(
          title: Text(currentWeather.cityName),
          subtitle: Text('Temperature: ${currentWeather.temperature}°C'),
          children: currentWeather.dailyForecasts.map((dailyWeather) {
            return ListTile(
              title: Text('${dailyWeather.dateTime.hour}:00'),
              subtitle: Text(
                  'Temp: ${dailyWeather.temperature}°C, ${dailyWeather.description}'),
            );
          }).toList(),
        );
      },
    );
  }
}

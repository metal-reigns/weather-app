import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/domain/entity/daily_weather.dart'; // Если используется SVG иконки

class WeatherExpansionTile extends StatelessWidget {
  final List<DailyWeather> dailyWeatherList;

  WeatherExpansionTile({Key? key, required this.dailyWeatherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyWeatherList.length,
      itemBuilder: (context, index) {
        final weather = dailyWeatherList[index];
        return ExpansionTile(
          title: Text(
            "Weather on ${weather.dateTime.toLocal()}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: SvgPicture.asset(weather.icon, width: 40, height: 40),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Temperature: ${weather.temperature}°C"),
                  Text("Description: ${weather.description}"),
                  Text("Wind Speed: ${weather.windSpeed} m/s"),
                  Text("Humidity: ${weather.humidity}%"),
                  Text("Pressure: ${weather.pressure} hPa"),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

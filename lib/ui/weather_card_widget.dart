import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entity/current_weather.dart';

class WeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var isMobile = constraints.maxWidth < 600;
        double cardWidth = isMobile ? constraints.maxWidth * 0.95 : 360;
        double cardHeight = isMobile ? 400 : 560;

        return Center(
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Stack(
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SvgPicture.asset(
                        getWeatherBackground(weather.detailedDescription),
                        width: cardWidth,
                        height: cardHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                  'http://openweathermap.org/img/w/${weather.weatherIcon}.png'),
                              Text(weather.mainDescription),
                              Text(
                                DateFormat('HH:mm').format(weather.dateTime),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                  '${weather.temperature.toStringAsFixed(1)}°C',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text('Humidity: ${weather.humidity}%',
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                  'Wind Speed: ${weather.windSpeed.toStringAsFixed(1)} m/s',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(weather.cityName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(
                                  'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
                                  style: const TextStyle(color: Colors.white)),
                              Text(weather.detailedDescription,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(
                                  'Visibility: ${(weather.visibility).toStringAsFixed(1)} km',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Pressure: ${weather.pressure} hPa',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String getWeatherBackground(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'assets/clear_sky.svg';
      case 'thunderstorm':
        return 'assets/thunderstorm.svg';
      case 'scattered clouds':
        return 'assets/scattered_clouds.svg';
      case 'rain':
        return 'assets/rain.svg';
      case 'snow':
        return 'assets/snow.svg';
      case 'mist':
        return 'assets/mist.svg';
      default:
        return 'assets/scattered_clouds.svg'; // Default image if no match found
    }
  }
}

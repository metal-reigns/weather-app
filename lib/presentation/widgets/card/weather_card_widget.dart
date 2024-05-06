import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/configuration/configuration.dart';
import 'package:weather_app/domain/entity/current_weather.dart';

class WeatherCardWidget extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherCardWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var isMobile = constraints.maxWidth < 600;
        double cardWidth = isMobile ? constraints.maxWidth : 385;
        return Center(
          child: SizedBox(
            width: cardWidth,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 335 / 185,
                    child: SvgPicture.asset(
                      _getWeatherBackground(weather.mainDescription),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                      '${Configuration.openWeather.imageUrl}/${weather.weatherIcon}.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      '${weather.temperature.toStringAsFixed(1)}°C',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(
                                    height: 70,
                                  )
                                ],
                              ),
                              InfoColumn(
                                  icon: Icons.thumbs_up_down_outlined,
                                  label: 'Feels like ',
                                  value:
                                      '${weather.feelsLike.toStringAsFixed(1)}°C'),
                              InfoColumn(
                                icon: Icons.water_drop,
                                label: 'Humidity',
                                value: '${weather.humidity}%',
                              ),
                              InfoColumn(
                                icon: Icons.air,
                                label: 'Wind',
                                value:
                                    '${weather.windSpeed.toStringAsFixed(1)} m/s',
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  weather.cityName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                    width: 10), // Spacing between text and icon
                                const Icon(Icons.location_on_outlined,
                                    size: 32, color: Colors.white),
                                const SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                            InfoColumn(
                                icon: Icons.wb_cloudy_outlined,
                                value: weather.detailedDescription),
                            InfoColumn(
                                icon: Icons.visibility,
                                label: 'Visibility:',
                                value:
                                    '${(weather.visibility / 1000).toStringAsFixed(1)} km'),
                            InfoColumn(
                                icon: Icons.compress,
                                label: 'Pressure',
                                value: '${weather.pressure} hPa'),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getWeatherBackground(String description) {
    switch (description.toLowerCase()) {
      case 'clear':
        return 'assets/clear.svg';
      case 'thunderstorm':
        return 'assets/thunderstorm.svg';
      case 'clouds':
        return 'assets/clouds.svg';
      case 'rain':
        return 'assets/rain.svg';
      case 'snow':
        return 'assets/snow.svg';
      case 'mist':
        return 'assets/mist.svg';
      default:
        return 'assets/mist.svg';
    }
  }
}

class InfoColumn extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String value;

  const InfoColumn({
    super.key,
    this.icon,
    this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
          height: 30,
        ),
        Text(label ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

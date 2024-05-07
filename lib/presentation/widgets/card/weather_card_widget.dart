import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/configuration/configuration.dart';
import 'package:weather_app/domain/entity/current_weather.dart';
import 'package:weather_app/i18n/translations.g.dart';

class WeatherCardWidget extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherCardWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final t = TranslationProvider.of(context).translations;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth < 475;
        double cardWidth = isMobile ? constraints.maxWidth * 0.95 : 510;

        double titleFontSize = isMobile ? 16 : 23;
        double detailFontSize = isMobile ? 13 : 16;
        double iconSize = isMobile ? 20 : 28;
        EdgeInsets padding = isMobile
            ? const EdgeInsets.only(top: 25, left: 15, right: 20, bottom: 5)
            : const EdgeInsets.only(top: 45, left: 25, right: 20, bottom: 5);
        String detailedDescription = weather.detailedDescription;
        String shortDescription = detailedDescription.length > 19
            ? '${detailedDescription.substring(0, 18)}...'
            : detailedDescription;

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
                    aspectRatio: 315 / 185,
                    child: SvgPicture.asset(
                      _getWeatherBackground(weather.mainDescription),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _TempWidget(
                                    weather: weather,
                                    titleFontSize: titleFontSize),
                                SizedBox(height: isMobile ? 10 : 30),
                                _InfoColumnWidget(
                                  icon: Icons.thumbs_up_down_outlined,
                                  label: '${t.feels_like}: ',
                                  value:
                                      '${weather.feelsLike.toStringAsFixed(1)}°C',
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                ),
                                _InfoColumnWidget(
                                  icon: Icons.water_drop,
                                  label: '${t.humidity}: ',
                                  value: '${weather.humidity}%',
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                ),
                                _InfoColumnWidget(
                                  icon: Icons.air,
                                  label: '${t.wind_speed}: ',
                                  value:
                                      '${weather.windSpeed.toStringAsFixed(1)} ${t.speed_unit}',
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _LocalWidget(
                                    iconSize: iconSize,
                                    weather: weather,
                                    titleFontSize: titleFontSize),
                                SizedBox(height: isMobile ? 10 : 30),
                                _InfoColumnWidget(
                                  icon: Icons.wb_cloudy_outlined,
                                  value: shortDescription,
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                  label: '',
                                ),
                                _InfoColumnWidget(
                                  icon: Icons.visibility,
                                  label: '${t.visibility}:',
                                  value:
                                      '${(weather.visibility / 1000).toStringAsFixed(1)} ${t.distance_unit}',
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                ),
                                _InfoColumnWidget(
                                  icon: Icons.compress,
                                  label: '${t.pressure}: ',
                                  value: '${weather.pressure} ${t.h_pa}',
                                  fontSize: detailFontSize,
                                  iconSize: iconSize,
                                ),
                              ],
                            ),
                          ],
                        ),
                        _InfoColumnWidget(
                          icon: Icons.timelapse,
                          label: '${t.last_update_time}: ',
                          value: _timeAgo(weather.dateTime),
                          fontSize: detailFontSize,
                          iconSize: iconSize,
                        ),
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

  String _timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 1) {
      return '${difference.inDays} ${t.day_ago}';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} ${t.hour_ago}';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} ${t.minutes_ago}';
    } else {
      return t.now;
    }
  }
}

class _LocalWidget extends StatelessWidget {
  const _LocalWidget({
    required this.iconSize,
    required this.weather,
    required this.titleFontSize,
  });

  final double iconSize;
  final CurrentWeather weather;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(height: 60),
        Icon(
          Icons.location_on_outlined,
          size: iconSize,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class _TempWidget extends StatelessWidget {
  const _TempWidget({
    required this.weather,
    required this.titleFontSize,
  });

  final CurrentWeather weather;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(height: 60),
        Image.network(
            '${Configuration.openWeather.imageUrl}/${weather.weatherIcon}.png'),
        const SizedBox(width: 10),
        Text('${weather.temperature.toStringAsFixed(1)}°C',
            style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}

class _InfoColumnWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double fontSize;
  final double iconSize;

  const _InfoColumnWidget({
    required this.icon,
    required this.label,
    required this.value,
    required this.fontSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: iconSize),
        const SizedBox(
          width: 10,
          height: 25,
        ),
        Text(label, style: TextStyle(color: Colors.white, fontSize: fontSize)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: fontSize)),
      ],
    );
  }
}

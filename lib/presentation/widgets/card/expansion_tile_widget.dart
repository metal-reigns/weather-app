import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/configuration/configuration.dart';
import 'package:weather_app/domain/entity/daily_weather.dart';
import 'package:weather_app/i18n/translations.g.dart';
import 'package:weather_app/services/theme/app_colors.dart';

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
        bool isMobile = constraints.maxWidth < 475;
        double cardWidth = isMobile ? constraints.maxWidth * 0.95 : 510;
        double titleFontSize = isMobile ? 12 : 16;
        double detailFontSize = isMobile ? 12 : 14;
        EdgeInsets padding = isMobile
            ? const EdgeInsets.symmetric(horizontal: 15)
            : const EdgeInsets.symmetric(horizontal: 20);

        Widget titleWidget = dailyWeatherList.isNotEmpty
            ? buildTitleWidget(dailyWeatherList.first, titleFontSize)
            : Text("No data available",
                style: TextStyle(fontSize: titleFontSize, color: Colors.white));

        return Container(
          width: cardWidth,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(20)),
          ),
          child: ExpansionTile(
            tilePadding: padding,
            title: titleWidget,
            trailing: const Icon(Icons.arrow_circle_down, color: Colors.white),
            children: dailyWeatherList
                .map((dailyWeather) =>
                    buildWeatherRow(dailyWeather, detailFontSize))
                .toList(),
          ),
        );
      },
    );
  }

  Widget buildTitleWidget(DailyWeather weather, double fontSize) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "${getWeekdayName(weather.dateTime)}, ${weather.dateTime.hour}:00 - ${weather.temperature.toStringAsFixed(1)}°C, ${weather.description}",
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ),
      ],
    );
  }

  Widget buildWeatherRow(DailyWeather dailyWeather, double fontSize) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${getWeekdayName(dailyWeather.dateTime)}, ${dailyWeather.dateTime.hour}:00',
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
          Text(
            "${dailyWeather.temperature.toStringAsFixed(1)}°C, ${dailyWeather.description}",
            style: TextStyle(color: Colors.white, fontSize: fontSize),
            textAlign: TextAlign.center,
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

  String getWeekdayName(DateTime date) {
    String weekday = DateFormat('EEEE').format(date).toLowerCase();

    switch (weekday) {
      case 'monday':
        return t.days.monday;
      case 'tuesday':
        return t.days.tuesday;
      case 'wednesday':
        return t.days.wednesday;
      case 'thursday':
        return t.days.thursday;
      case 'friday':
        return t.days.friday;
      case 'saturday':
        return t.days.saturday;
      case 'sunday':
        return t.days.sunday;
      default:
        return '';
    }
  }
}

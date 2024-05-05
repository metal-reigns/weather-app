// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weather_app/weather_widget_model.dart';
//
// class WeatherCarousel extends StatelessWidget {
//   final List<Weather> weathers;
//
//   WeatherCarousel({Key? key, required this.weathers}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: weathers.length,
//       itemBuilder: (context, index) {
//         return WeatherCard(weather: weathers[index]);
//       },
//     );
//   }
// }
//
// class WeatherCard extends StatelessWidget {
//   final Weather weather;
//
//   const WeatherCard({Key? key, required this.weather}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey[800],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(weather.cityName,
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//           SizedBox(height: 8),
//           Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: weather.hourlyWeather.length,
//               itemBuilder: (context, index) {
//                 HourlyWeather hourly = weather.hourlyWeather[index];
//                 return Card(
//                   child: Container(
//                     width: 150,
//                     padding: EdgeInsets.all(8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(DateFormat('ha').format(hourly.time),
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold)),
//                         Text('${hourly.temperature.toStringAsFixed(1)}°C',
//                             style: TextStyle(color: Colors.black)),
//                         Text(hourly.description,
//                             style: TextStyle(color: Colors.black)),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:weather_app/hourly_weather.dart';
// import 'package:weather_app/weather_widget_model.dart';
//
// class WeatherCarousel extends StatelessWidget {
//   final List<Weather> weathers;
//
//   WeatherCarousel({Key? key, required this.weathers}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       itemCount: weathers[0]
//           .hourlyForecasts
//           .length, // Предполагаем, что данные загружены
//       itemBuilder: (context, index) {
//         HourlyWeather hourlyWeather = weathers[0].hourlyForecasts[index];
//         return WeatherCard(hourlyWeather: hourlyWeather);
//       },
//     );
//   }
// }
//
// class WeatherCard extends StatelessWidget {
//   final HourlyWeather hourlyWeather;
//
//   WeatherCard({Key? key, required this.hourlyWeather}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Реализация карточки с данными hourlyWeather
//     return Card(
//       child: Column(
//         children: [
//           Text("${hourlyWeather.temperature}°C"),
//           Text(hourlyWeather.description),
//           // Добавьте другие поля как нужно
//         ],
//       ),
//     );
//   }
// }

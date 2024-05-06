class Configuration {
  static final openWeather = _OpenWeather();
  static final ipInfo = _IpInfo();
}

class _OpenWeather {
  final String host = 'https://api.openweathermap.org/data/2.5';
  final String apiKey = '6f1d3f3c24abb10a55e458cdc5a18390';
  final String imageUrl = 'http://openweathermap.org/img/w';
}

class _IpInfo {
  final String host = 'https://ipinfo.io';
  final String apiKey = '4239c685d6b877';
}

class WeatherData {
  final String city;
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double windSpeed;
  final String icon;
  final String description;
  final int humidity;
  final List<ForecastData> forecast;

  WeatherData({
    required this.city,
    required this.icon,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.windSpeed,
    required this.description,
    required this.humidity,
    required this.forecast,
  });
}

class ForecastData {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final String icon;
  final String description;

  ForecastData({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.icon,
    required this.description,
  });
}

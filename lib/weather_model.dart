class WeatherData {
  final String city;
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double windSpeed;
  final String icon;
  final String description;
  final int humidity;
  final double pressure;
  final double realFeel;
  final DateTime sunrise;
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
    required this.pressure,
    required this.realFeel,
    required this.sunrise,
    required this.forecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var forecastList = json['list'] as List;
    List<ForecastData> forecastDataList =
        forecastList.map((item) => ForecastData.fromJson(item)).toList();

    return WeatherData(
      city: json['name'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'] - 273.15,
      maxTemperature: json['main']['temp_max'] - 273.15,
      minTemperature: json['main']['temp_min'] - 273.15,
      windSpeed: json['wind']['speed'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      realFeel: json['main']['feels_like'] - 273.15,
      sunrise:
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      forecast: forecastDataList,
    );
  }
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

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      maxTemperature: json['main']['temp_max'] - 273.15,
      minTemperature: json['main']['temp_min'] - 273.15,
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}

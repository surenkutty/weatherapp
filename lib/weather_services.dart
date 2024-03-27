import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather_model.dart';
// import 'package:weatherapp/weather_model.dart';

class WeatherApi {
  final String apiKey =
      'f0e65d5cd1cf7e3cd8181924a345a20a'; // Replace with your actual API key

  Future<WeatherData> fetchWeather(String city) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cityName = data['city']['name'];
        final icon = data['list'][0]['weather'][0]['icon'];
        final temp = data['list'][0]['main']['temp'] - 273.15;
        final maxTemp = data['list'][0]['main']['temp_max'] - 273.15;
        final minTemp = data['list'][0]['main']['temp_min'] - 273.15;
        final windSpeed = data['list'][0]['wind']['speed'];
        final description = data['list'][0]['weather'][0]['description'];

        final humidity = data['list'][0]['main']['humidity'];
        print(humidity);
        print(description);
        final List<ForecastData> forecast = [];
        for (var i = 0; i < data['list'].length; i += 8) {
          final item = data['list'][i];
          final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000,
              isUtc: false);
          final maxTemp = item['main']['temp_max'] - 273.15;
          final minTemp = item['main']['temp_min'] - 273.15;
          final icon = item['weather'][0]['icon'];

          forecast.add(ForecastData(
            date: date,
            maxTemperature: maxTemp,
            minTemperature: minTemp,
            icon: icon,
            // description: description,
            description: item['weather'][0]['description'],
          ));
        }

        return WeatherData(
          city: cityName,
          icon: icon,
          temperature: temp,
          maxTemperature: maxTemp,
          minTemperature: minTemp,
          windSpeed: windSpeed,
          description: description,
          humidity: humidity,
          forecast: forecast,
        );
      } else {
        throw Exception(
            'Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}

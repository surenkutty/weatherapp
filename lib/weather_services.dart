import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherApi {
  final String apiKey =
      'f0e65d5cd1cf7e3cd8181924a345a20a'; // Replace with your actual API key

  Future<WeatherData> fetchWeather(String city) async {
    try {
      // Fetch current weather data
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Current Weather Data: $data'); // Debug print

        // Fetch forecast data
        final forecastResponse = await http.get(Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'));

        if (forecastResponse.statusCode == 200) {
          final forecastData = json.decode(forecastResponse.body)['list'];
          print('Forecast Data: $forecastData'); // Debug print
          List<ForecastData> forecast = [];

          for (var item in forecastData) {
            final date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
            final maxTemp =
                (item['main']['temp_max'] as num).toDouble() - 273.15;
            final minTemp =
                (item['main']['temp_min'] as num).toDouble() - 273.15;
            final icon = item['weather'][0]['icon'];
            final description = item['weather'][0]['description'];

            forecast.add(ForecastData(
              date: date,
              maxTemperature: maxTemp,
              minTemperature: minTemp,
              icon: icon,
              description: description,
            ));
          }

          final cityName = data['name'];
          final icon = data['weather'][0]['icon'];
          final temp = (data['main']['temp'] as num).toDouble() - 273.15;
          final maxTemp = (data['main']['temp_max'] as num).toDouble() - 273.15;
          final minTemp = (data['main']['temp_min'] as num).toDouble() - 273.15;
          final windSpeed = (data['wind']['speed'] as num).toDouble();
          final description = data['weather'][0]['description'];
          final humidity = data['main']['humidity'] as int;
          final pressure = (data['main']['pressure'] as num).toDouble();
          final realFeel =
              (data['main']['feels_like'] as num).toDouble() - 273.15;
          final sunrise = DateTime.fromMillisecondsSinceEpoch(
              data['sys']['sunrise'] * 1000);

          return WeatherData(
            city: cityName,
            icon: icon,
            temperature: temp,
            maxTemperature: maxTemp,
            minTemperature: minTemp,
            windSpeed: windSpeed,
            description: description,
            humidity: humidity,
            pressure: pressure,
            realFeel: realFeel,
            sunrise: sunrise,
            forecast: forecast,
          );
        } else {
          throw Exception(
              'Failed to load forecast data. Status code: ${forecastResponse.statusCode}');
        }
      } else {
        throw Exception(
            'Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e'); // Debug print
      throw Exception('Error fetching weather data: $e');
    }
  }
}

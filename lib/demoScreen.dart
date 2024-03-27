import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:weatherapp/weather_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherApi weatherApi = WeatherApi();
  final TextEditingController cityController = TextEditingController();
  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _fetchWeatherData(cityController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                _fetchWeatherData(value);
              },
            ),
            SizedBox(height: 20.0),
            if (weatherData != null) ...[
              _buildCurrentWeatherWidget(weatherData!),
              SizedBox(height: 20.0),
              _buildForecastWidget(weatherData!.forecast),
            ],
          ],
        ),
      ),
    );
  }

  void _fetchWeatherData(String city) async {
    try {
      final fetchedWeatherData = await weatherApi.fetchWeather(city);
      setState(() {
        weatherData = fetchedWeatherData;
      });
    } catch (e) {
      _showErrorDialog('Failed to fetch weather data. Please try again.');
    }
  }

  Widget _buildCurrentWeatherWidget(WeatherData weatherData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          weatherData.city,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        SvgPicture.asset(
          'assets/icons/${_mapIconCode(weatherData.icon)}.svg',
          // 'assets/icons/rainDay.svg',
          semanticsLabel: 'Weather Icon',
          height: 100,
          width: 100,
        ),
        // Image.network(
        //   'https://openweathermap.org/img/w/${weatherData.icon}.png',
        //   height: 100,
        //   width: 100,
        // ),
        SizedBox(height: 10.0),
        Text(
          '${weatherData.temperature.toStringAsFixed(1)}°C',
          style: TextStyle(fontSize: 30.0),
        ),
        SizedBox(height: 5.0),
        Text(
          '${weatherData.description}',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8),
        Text(
          'Wind Speed: ${weatherData.windSpeed} m/s',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Humidity: ${weatherData.humidity} %', // Display humidity
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildForecastWidget(List<ForecastData> forecast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5-Day Forecast',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: forecast
                .map((forecastItem) => _buildForecastItem(forecastItem))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildForecastItem(ForecastData forecastItem) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEE, MMM d').format(forecastItem.date),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              // Image.network(
              //   'https://openweathermap.org/img/w/${forecastItem.icon}.png',
              //   height: 40,
              //   width: 40,
              // ),

              SvgPicture.asset(
                'assets/icons/${_mapIconCode(forecastItem.icon)}.svg',
                semanticsLabel: 'Weather Icon',
                height: 30,
                width: 30,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max: ${forecastItem.maxTemperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Min: ${forecastItem.minTemperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    forecastItem.description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _mapIconCode(String iconcode) {
    switch (iconcode) {
      case '01d':
        return 'clearSkyDay';
      case '01n':
        return 'clearSkyNight';
      case '02d':
        return 'fewCloudsDay';
      case '02n':
        return 'fewCloudsNight';
      case '03d':
        return 'ScatteredClouds';
      case '03n':
        return 'ScatteredClouds';
      case '04d':
        return 'brokenClouds';
      case '04n':
        return 'brokenClouds';
      case '09d':
        return 'showeRain';
      case '09n':
        return 'showeRain';
      case '10d':
        return 'rainDay';
      case '10n':
        return 'rainNight';
      case '11d':
        return 'thunderstromDay';
      case '11n':
        return 'thunderstromNight';
      case '13d':
        return 'snowDay';
      case '13n':
        return 'snowNight';
      case '50d':
        return 'mistDay';
      case '50n':
        return 'mistNight';

      // Add more cases for other weather conditions as needed
      default:
        return 'default_icon'; // Use a default icon for unknown conditions
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

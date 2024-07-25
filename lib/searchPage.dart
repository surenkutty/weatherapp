import 'package:flutter/material.dart';
import 'package:weatherapp/weather_services.dart';
import 'package:weatherapp/weather_model.dart';

class SearchPage extends StatefulWidget {
  final Function(WeatherData)
      onWeatherSelected; // Callback to update weather on the front page

  SearchPage({required this.onWeatherSelected});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final WeatherApi _weatherApi = WeatherApi();
  WeatherData? _weatherData;
  String _errorMessage = '';

  Future<void> _searchWeather() async {
    final city = _controller.text.trim();
    if (city.isEmpty) return;

    try {
      final data = await _weatherApi.fetchWeather(city);
      setState(() {
        _weatherData = data;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _weatherData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchWeather,
                ),
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (_weatherData != null) ...[
              Text(
                '${_weatherData!.city}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '${_weatherData!.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${_weatherData!.description}',
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onWeatherSelected(_weatherData!);
                  Navigator.pop(context);
                },
                child: Text('Go to Weather Details'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weatherapp/Widgets/drawer.dart';
import 'package:weatherapp/newUi.dart';
import 'package:weatherapp/searchPage.dart';
import 'package:weatherapp/weather_services.dart';
import 'package:weatherapp/weather_model.dart';
// Import WeatherScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  WeatherData? _currentWeatherData;
  final WeatherApi _weatherApi = WeatherApi();

  void _updateWeatherData(WeatherData data) {
    setState(() {
      _currentWeatherData = data;
    });
  }

  Future<void> _fetchInitialWeather() async {
    try {
      final data = await _weatherApi.fetchWeather('America');
      _updateWeatherData(data);
    } catch (e) {
      print('Error fetching initial weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchInitialWeather();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _currentWeatherData != null
          ? WeatherScreen(weatherData: _currentWeatherData!)
          : Center(child: CircularProgressIndicator()),
      SearchPage(onWeatherSelected: _updateWeatherData),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Weather App'),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        // drawer: drawerwidget(),
      ),
    );
  }
}

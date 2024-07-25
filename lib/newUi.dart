import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherData weatherData;

  WeatherScreen({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Main weather container
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(16.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3),
              //   ),
              // ],
            ),
            child: Column(
              children: [
                // City Name
                Text(
                  weatherData.city,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 10.0),
                SvgPicture.asset(
                  'assets/icons/${_mapIconCode(weatherData.icon)}.svg',
                  // 'assets/icons/rainDay.svg',
                  semanticsLabel: 'Weather Icon',
                  height: 100,
                  width: 100,
                ),

                // Weather Image
                // Image.network(
                //   'http://openweathermap.org/img/wn/${weatherData.icon}.png',
                //   height: 100,
                //   width: 100,
                // ),
                SizedBox(height: 16.0),

                // Temperature
                Text(
                  '${weatherData.temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 8.0),

                // Weather Description
                Text(
                  weatherData.description,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16.0),

                // Small Containers with Icons
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    _buildInfoCard(Icons.wind_power, 'Wind Speed',
                        '${weatherData.windSpeed} m/s'),
                    _buildInfoCard(
                        Icons.opacity, 'Humidity', '${weatherData.humidity}%'),
                    _buildInfoCard(
                        Icons.speed, 'Pressure', '${weatherData.pressure} hPa'),
                    _buildInfoCard(Icons.ac_unit, 'Feels Like',
                        '${weatherData.realFeel.toStringAsFixed(1)}°C'),
                    _buildInfoCard(
                        Icons.sunny,
                        'Sunrise',
                        DateFormat('h:mm a')
                            .format(weatherData.sunrise.toLocal())),
                  ],
                ),
              ],
            ),
          ),

          // Forecast section (Swipeable)
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),

                // Swipeable Forecast Data
                Container(
                  height: 200, // Adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherData.forecast.length,
                    itemBuilder: (context, index) {
                      final forecast = weatherData.forecast[index];
                      return Container(
                        margin: EdgeInsets.only(right: 8.0),
                        width: 150,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd MMM')
                                  .format(forecast.date.toLocal()),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),

                            SvgPicture.asset(
                              'assets/icons/${_mapIconCode(forecast.icon)}.svg',
                              semanticsLabel: 'Weather Icon',
                              height: 50,
                              width: 50,
                            ),
                            // Image.network(
                            //   'http://openweathermap.org/img/wn/${forecast.icon}.png',
                            //   height: 50,
                            //   width: 50,
                            // ),
                            SizedBox(height: 8.0),
                            Text(
                              '${forecast.maxTemperature.toStringAsFixed(1)}°C / ${forecast.minTemperature.toStringAsFixed(1)}°C',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              forecast.description,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      width: 80, // Uniform width
      height: 110, // Uniform height
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.blue,
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
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
}

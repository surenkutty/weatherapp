// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weatherapp/weather_model.dart';
// import 'package:weatherapp/weather_services.dart';

// class WeeatherScreen extends StatelessWidget {
//   final WeatherApi weatherApi = WeatherApi();
//   final TextEditingController cityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: cityController,
//           decoration: InputDecoration(labelText: 'Enter City Name'),
//         ),
//         SizedBox(height: 16),
//         ElevatedButton(
//           onPressed: () async {
//             final cityName = cityController.text;
//             try {
//               final weatherData = await weatherApi.fetchWeatherData(cityName);
//               _showWeatherUI(context, weatherData);
//             } catch (e) {
//               _showErrorDialog(context,
//                   'Failed to fetch weather data. Please check your input and try again.');
//             }
//           },
//           child: Text('Get Weather'),
//         ),
//       ],
//     );
//   }

//   void _showWeatherUI(BuildContext context, WeatherData weatherData) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Scaffold(
//           appBar: AppBar(title: Text(weatherData.city)),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.network(
//                   'https://openweathermap.org/img/w/${weatherData.icon}.png',
//                   height: 100,
//                   width: 100,
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   '${weatherData.temperature.toStringAsFixed(1)}°C',
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Max: ${weatherData.maxTemperature.toStringAsFixed(1)}°C, Min: ${weatherData.minTemperature.toStringAsFixed(1)}°C',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Wind Speed: ${weatherData.windSpeed} m/s',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   weatherData.description,
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   '7-Day Forecast',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: weatherData.forecast.length,
//                     itemBuilder: (context, index) {
//                       final forecastItem = weatherData.forecast[index];

//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ListTile(
//                             title: Text(
//                               DateFormat('EEE, MMM d')
//                                   .format(forecastItem.date),
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             subtitle: Row(
//                               children: [
//                                 Text(
//                                   'Max: ${forecastItem.maxTemperature.toStringAsFixed(1)}°C',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Min: ${forecastItem.minTemperature.toStringAsFixed(1)}°C',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             leading: Image.network(
//                               'https://openweathermap.org/img/w/${forecastItem.icon}.png',
//                               height: 40,
//                               width: 40,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showErrorDialog(BuildContext context, String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(errorMessage),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weatherapp/weather_model.dart';
// import 'package:weatherapp/weather_services.dart';

// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//       ),
//     );
//   }

//   void _fetchWeather(String cityName) async {
//     try {
//       final fetchedWeatherData = await weatherApi.fetchWeather(cityName);
//       setState(() {
//         weatherData = fetchedWeatherData;
//       });
//     } catch (e) {
//       _showErrorDialog(
//         context,
//         'Failed to fetch weather data. Please check your input and try again.',
//       );
//     }
//   }
//   }
// }











// import 'package:flutter/material.dart';

// class AttractiveSearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onSubmitted;

//   const AttractiveSearchBar(
//       {Key? key, required this.controller, required this.onSubmitted})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: TextField(
//                 controller: controller,
//                 onSubmitted: onSubmitted,
//                 decoration: InputDecoration(
//                   hintText: 'Enter City Name',
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
//                 ),
//               ),
//             ),
//           ),
//           // SizedBox(width: 8),
//           GestureDetector(
//             onTap: () {
//               onSubmitted(controller.text);
//             },
//             child: Icon(Icons.search),
//           ),
//         ],
//       ),
//     );
//   }
// }

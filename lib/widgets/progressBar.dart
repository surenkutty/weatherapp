import 'package:flutter/material.dart';

class HumidityProgressBar extends StatelessWidget {
  final int humidity;

  HumidityProgressBar({required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: humidity / 100, // Convert humidity to progress value
                  strokeWidth:
                      10, // Adjust the thickness of the progress indicator
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Customize the color
                ),
              ),
              Icon(
                Icons.water_drop, // Use water drop icon to represent humidity
                size: 30, // Adjust the size of the icon
                color: Colors.blue, // Customize the color
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Define a method to choose color based on humidity level
  Color _getColor(int humidity) {
    if (humidity < 30) {
      return Colors.blue; // Low humidity, show blue color
    } else if (humidity < 80) {
      return Colors.green; // Moderate humidity, show green color
    } else {
      return Colors.red; // High humidity, show red color
    }
  }
}

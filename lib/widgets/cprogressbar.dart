import 'package:flutter/material.dart';

class PressureCircularProgress extends StatelessWidget {
  final double pressure;

  const PressureCircularProgress({Key? key, required this.pressure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: pressure / 1000, // Assuming pressure range is 0-1000
                strokeWidth: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              Center(
                child: Text(
                  pressure.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Pressure (hPa)',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class RealFeelCircularProgress extends StatelessWidget {
  final double realFeel;

  const RealFeelCircularProgress({Key? key, required this.realFeel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: realFeel / 100, // Assuming realFeel range is 0-100
                strokeWidth: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              Center(
                child: Text(
                  realFeel.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Real Feel (°C)',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

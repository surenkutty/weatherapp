import 'package:flutter/material.dart';
// import 'package:weatherapp/weather_screen.dart';
import 'package:weatherapp/Widgets/drawer.dart';
import 'package:weatherapp/demoScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WeatherScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Weather App',
          ),
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
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.black12,
            ),
          ],
        ),
        drawer: drawerwidget(),
        // floatingActionButton: FloatingActionButton(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with your existing settings screen UI
    return Center(
      child: Text('Settings Screen'),
    );
  }
}

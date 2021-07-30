import 'package:flutter/material.dart';
import 'package:simple_weather_app/current_weather.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Simple weather app'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cityTextController = TextEditingController();
  String cityName = '';

  void setNewLocation(String str) {
    setState(() {
      cityName = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: Column(children: [
            cityName == '' ? Text('Write a city') : CurrentWeather(cityName),
            TextField(
              decoration: InputDecoration(
                hintText: 'City',
              ),
              controller: cityTextController,
              onChanged: (String str) {
                setNewLocation(str);
              },
            )
          ]),
        ));
  }
}

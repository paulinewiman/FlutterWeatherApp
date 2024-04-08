import 'package:flutter/material.dart';
import 'package:project/utils/theme.dart';
import 'package:project/weather_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
    );
  }
}

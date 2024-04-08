import 'dart:collection';
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:project/models/air_quality.dart';
import 'package:project/models/current_weather.dart';
import 'package:project/models/forecast.dart';
import 'package:project/models/weather.dart';
import 'package:project/utils/constants.dart';

Future getCurrentWeather(Location location) async {
  CurrentWeather weather;
  String lat = location.latitude.toString();
  String lon = location.longitude.toString();
  var url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weather = CurrentWeather.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error loading weather data!");
  }

  return weather;
}

Future getWeatherForecast(Location location) async {
  Forecast forecast;
  String lat = location.latitude.toString();
  String lon = location.longitude.toString();
  var url =
      'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error loading weather forecast data!");
  }

  return forecast;
}

Future getCurrentAirQuality(Location location) async {
  AirQuality airQuality;
  String lat = location.latitude.toString();
  String lon = location.longitude.toString();
  var url =
      'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    airQuality = AirQuality.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error loading air quality data!");
  }

  return airQuality;
}

/* 
 * A function that takes a weather-forecast as a parameter. 
 * It returns a Map where the key is a datetime(for example July 31st 2023),
 * and the value is a list of weather-data for that day.
 */
Map<DateTime, List<Weather>> getWeathersPerDay(Forecast forecast) {
  Map<Weather, DateTime> dateTimePerWeather =
      getDateTimePerWeather(forecast.weatherPerHour);

  Map<DateTime, List<Weather>> weathersPerDay =
      SplayTreeMap((a, b) => a.compareTo(b));

  dateTimePerWeather.forEach((key, value) {
    Weather w = key;
    DateTime dt = value;
    List<Weather>? weathersPerDayList = weathersPerDay[dt];

    if (weathersPerDayList == null) {
      weathersPerDayList = [];
      weathersPerDay[dt] = weathersPerDayList;
    }

    weathersPerDayList.add(w);
  });

  return weathersPerDay;
}

/* 
 * A function that takes a list of Weathers as a parameter. 
 * It returns a Map where the key is a Weather,
 * and the value is the Weather's date.
 */
Map<Weather, DateTime> getDateTimePerWeather(List<Weather> weathers) {
  Map<Weather, DateTime> dateTimePerWeather =
      SplayTreeMap((a, b) => a.datetime.compareTo(b.datetime));

  for (Weather weather in weathers) {
    DateTime longDateTime =
        DateTime.fromMillisecondsSinceEpoch(weather.datetime * 1000);

    // Datetime that only consists of a date
    DateTime shortDateTime =
        DateTime(longDateTime.year, longDateTime.month, longDateTime.day);

    dateTimePerWeather.putIfAbsent(weather, () => shortDateTime);
  }

  return dateTimePerWeather;
}

String capitalize(String text) {
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

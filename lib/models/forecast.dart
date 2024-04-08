import 'package:project/models/weather.dart';

class Forecast {
  final List<Weather> weatherPerHour;

  Forecast({
    required this.weatherPerHour,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> weatherPerHourData = json['list'];
    List<Weather> weathers = <Weather>[];

    for (var element in weatherPerHourData) {
      var weather = Weather.fromJson(element);
      weathers.add(weather);
    }
    return Forecast(
      weatherPerHour: weathers,
    );
  }
}

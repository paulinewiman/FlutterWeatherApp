class CurrentWeather {
  final int temp;
  final String description;
  final String icon;
  final int datetime;
  final double wind;
  final int cloudiness;

  CurrentWeather({
    required this.temp,
    required this.description,
    required this.icon,
    required this.datetime,
    required this.wind,
    required this.cloudiness,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temp: json['main']['temp'].toInt(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      datetime: json['dt'],
      wind: json['wind']['speed'],
      cloudiness: json['clouds']['all'],
    );
  }
}

class Weather {
  final int temp;
  final String main;
  final String icon;
  final int datetime;

  Weather({
    required this.temp,
    required this.main,
    required this.icon,
    required this.datetime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toInt(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      datetime: json['dt'],
    );
  }
}
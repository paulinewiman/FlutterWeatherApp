class AirQuality {
  final int airQuality;

  AirQuality({
    required this.airQuality,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      airQuality: json['list'][0]['main']['aqi'],
    );
  }
}



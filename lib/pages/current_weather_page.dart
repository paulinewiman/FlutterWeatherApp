import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import 'package:project/models/air_quality.dart';
import 'package:project/models/current_weather.dart';
import 'package:project/utils/colors.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/functions.dart';
import 'package:project/utils/theme.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({
    super.key,
    required this.location,
    required this.locationName,
  });
  final Location location;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    CurrentWeather weather;

    AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.place),
          const SizedBox(width: 5),
          Text(
            locationName.toUpperCase(),
            style: appBarTitleTextStyle,
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.accentLightBlue,
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            weather = snapshot.data;
            return CurrentWeatherContainer(
              weather: weather,
              location: location,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: getCurrentWeather(location),
      ),
    );
  }
}

class CurrentWeatherContainer extends StatelessWidget {
  const CurrentWeatherContainer({
    super.key,
    required this.weather,
    required this.location,
  });

  final CurrentWeather weather;
  final Location location;

  @override
  Widget build(BuildContext context) {
    String imageName = weather.icon.substring(0, weather.icon.length - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > 570) {
          return Stack(
            alignment: Alignment.center,
            children: [
              weatherBackgrounds[imageName] ?? defaultBackground,
              WeatherBox(
                weather: weather,
                location: location,
                top: 110,
              ),
            ],
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              weatherBackgrounds[imageName] ?? defaultBackground,
              WeatherBox(
                weather: weather,
                location: location,
                top: 30,
              ),
            ],
          );
        }
      },
    );
  }
}

class WeatherBox extends StatelessWidget {
  const WeatherBox(
      {super.key,
      required this.weather,
      required this.location,
      required this.top});

  final CurrentWeather weather;
  final Location location;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Column(
        children: [
          WeatherDescriptionContainer(weather: weather),
          WeatherDataContainer(weather: weather, location: location),
        ],
      ),
    );
  }
}

class WeatherDescriptionContainer extends StatelessWidget {
  const WeatherDescriptionContainer({super.key, required this.weather});
  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime =
        DateTime.fromMillisecondsSinceEpoch(weather.datetime * 1000);

    return Column(
      children: [
        Text(
          "${weather.temp}°",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Transform.translate(
          offset: const Offset(0, -35),
          child: Text(
            capitalize(weather.description),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -30),
          child: Text(
            DateFormat("EEE, d MMMM,").add_Hm().format(currentDateTime),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}

class WeatherDataContainer extends StatelessWidget {
  const WeatherDataContainer({
    super.key,
    required this.weather,
    required this.location,
  });

  final CurrentWeather weather;
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -15),
      child: Card(
        elevation: 2,
        surfaceTintColor: AppColors.white,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeatherDataTile(
              icon: Icons.cloud,
              title: "Cloudiness",
              data: "${weather.cloudiness}%",
            ),
            WeatherDataTile(
              icon: Icons.air,
              title: "Wind",
              data: "${weather.wind} m/s",
            ),
            AirQualityTile(location: location),
          ],
        ),
      ),
    );
  }
}

class WeatherDataTile extends StatelessWidget {
  const WeatherDataTile({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final IconData icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: tileBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              Text(data, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          Icon(icon, color: AppColors.primaryTeal, size: 30),
        ],
      ),
    );
  }
}

class AirQualityTile extends StatelessWidget {
  const AirQualityTile({super.key, required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    AirQuality airQuality;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          airQuality = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Air Quality",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  airQualityNames[airQuality.airQuality - 1],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: getCurrentAirQuality(location),
    );
  }
}

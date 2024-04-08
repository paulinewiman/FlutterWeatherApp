import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:project/models/forecast.dart';
import 'package:project/models/weather.dart';
import 'package:project/utils/colors.dart';
import 'package:project/utils/functions.dart';
import 'package:project/utils/theme.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({
    super.key,
    required this.location,
    required this.locationName,
  });
  final Location location;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    Forecast forecast;

    AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.place),
          const SizedBox(width: 5),
          Text(
            locationName.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      backgroundColor: AppColors.primaryTeal,
      foregroundColor: AppColors.white,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.backgroundOffWhite,
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            forecast = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: Text(
                      "Forecast",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  ForecastContainer(forecast: forecast),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: getWeatherForecast(location),
      ),
    );
  }
}

class ForecastContainer extends StatelessWidget {
  const ForecastContainer({super.key, required this.forecast});
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Weather>> weathersPerDay = getWeathersPerDay(forecast);

    List<DailyWeatherCard> weatherCards = [];

    weathersPerDay.forEach((key, value) {
      weatherCards.add(DailyWeatherCard(
        dateTime: key,
        weathers: value,
      ));
    });

    return Expanded(
      child: ListView.builder(
        itemCount: weatherCards.length,
        shrinkWrap: true,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return weatherCards[index];
        },
      ),
    );
  }
}

class DailyWeatherCard extends StatelessWidget {
  const DailyWeatherCard({
    super.key,
    required this.dateTime,
    required this.weathers,
  });

  final DateTime dateTime;
  final List<Weather> weathers;

  List<WeatherDataRow> _getWeatherDataRows(List<Weather> weathers) {
    List<WeatherDataRow> rows = [];

    for (Weather weather in weathers) {
      rows.add(WeatherDataRow(weather: weather));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    String weekday = DateFormat.EEEE().format(dateTime);
    String date = DateFormat("d MMMM").format(dateTime);

    List<WeatherDataRow> weatherDataRows = _getWeatherDataRows(weathers);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: weatherCardBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weekday, style: Theme.of(context).textTheme.titleLarge),
                  Text(date, style: Theme.of(context).textTheme.labelSmall)
                ],
              ),
            ),
            Column(
              children: weatherDataRows,
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDataRow extends StatelessWidget {
  const WeatherDataRow({
    super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(weather.datetime * 1000);

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 7),
      decoration: weatherDataRowBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.network(
                "http://openweathermap.org/img/wn/${weather.icon}@2x.png",
                width: 40,
              ),
              Text(
                capitalize(weather.main),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(width: 30),
          Row(
            children: [
              const Icon(Icons.schedule),
              const SizedBox(width: 5),
              Text(
                DateFormat.Hm().format(dateTime),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.thermostat),
              Text(
                "${weather.temp}°C",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:project/pages/about_page.dart';
import 'package:project/pages/current_weather_page.dart';
import 'package:project/pages/forecast_page.dart';
import 'package:project/utils/colors.dart';
import 'package:project/utils/constants.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Location? _location;
  String? _locationName;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future getLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (!permissionStatus.isGranted) return;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    Location location = Location(
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: position.timestamp!,
    );

    setState(() {
      _location = location;
      _locationName =
          '${place.subLocality}, ${place.isoCountryCode}'.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    void onTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    final List<Widget> pages = [
      CurrentWeatherPage(
        location: _location ?? defaultLocation,
        locationName: _locationName ?? defaultLocationName,
      ),
      ForecastPage(
        location: _location ?? defaultLocation,
        locationName: _locationName ?? defaultLocationName,
      ),
      const AboutPage(),
    ];

    final List<BottomNavigationBarItem> menuItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.wb_sunny_outlined),
        activeIcon: Icon(Icons.sunny),
        label: "Current",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.analytics_outlined),
        activeIcon: Icon(Icons.analytics),
        label: "Forecast",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        activeIcon: Icon(Icons.info),
        label: "About",
      ),
    ];

    final BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      items: menuItems,
      currentIndex: _selectedIndex,
      selectedItemColor: AppColors.black,
      backgroundColor: AppColors.white,
      onTap: onTap,
    );

    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

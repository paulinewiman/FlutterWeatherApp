import 'package:geocoding/geocoding.dart';
import 'package:project/utils/widgets.dart';

const String apiKey = "29a9abcb6adb5363c089915fb44e1e46";

const List<String> airQualityNames = [
  "Good",
  "Fair",
  "Moderate",
  "Poor",
  "Very Poor"
];

final Location defaultLocation = Location(
  latitude: 59.334591,
  longitude: 18.063240,
  timestamp: DateTime.now(),
);

const String defaultLocationName = "Stockholm, SE";

const Map<String, PositionedImage> weatherBackgrounds = {
  "01": PositionedImage(top: -125, left: null, imageName: "01"),
  "02": PositionedImage(top: -130, left: null, imageName: "02"),
  "03": PositionedImage(top: -30, left: 20, imageName: "03"),
  "04": PositionedImage(top: -15, left: null, imageName: "04"),
  "09": PositionedImage(top: -30, left: null, imageName: "09"),
  "10": PositionedImage(top: -45, left: null, imageName: "10"),
  "11": PositionedImage(top: -30, left: null, imageName: "11"),
  "13": PositionedImage(top: -35, left: 20, imageName: "13"),
  "50": PositionedImage(top: -20, left: 10, imageName: "50")
};

const PositionedImage defaultBackground =
    PositionedImage(top: -35, left: 20, imageName: "01");

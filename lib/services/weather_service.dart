import 'package:weather/weather.dart';
import 'package:weather_app/app/app.logger.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final logger = getLogger('WeatherService');

  Future<Weather> fetchWeather() async {
    late Weather response;
    Position position = await _determinPosition();
    try {
      String key = 'f2caa4b94420384c592488607fae64d6';
      WeatherFactory wf = WeatherFactory(key);

      response = await wf.currentWeatherByLocation(
          position.latitude, position.longitude);

      return response;
    } catch (error) {
      logger.e(error);
    }
    return response;
  }

  Future<Position> _determinPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

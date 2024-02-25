import 'package:weather/weather.dart';
import 'package:weather_app/app/app.locator.dart';
import 'package:weather_app/app/app.logger.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  final logger = getLogger('HomeViewModel');
  final _weatherService = locator<WeatherService>();

  @override
  Future<Weather> futureToRun() => _weatherService.fetchWeather();

  @override
  void onData(data) {
    logger.d(data);
  }
}

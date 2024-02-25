import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/app/app.locator.dart';
import 'package:weather_app/services/weather_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WeatherServiceTest -', () {
    setUp(() => registerServices());
    test('Fetch current weather in a location', () async {
      var weatherService = WeatherService();

      var response = await weatherService.fetchWeather();
      print(response);
      expect(response.areaName, 'Willbrook');
    });
    tearDown(() => locator.reset());
  });
}

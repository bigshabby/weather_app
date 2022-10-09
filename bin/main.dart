import 'dart:io';
import 'dart:async';
import 'geocoding_api_client.dart';
import 'weather_api_client.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  final env = DotEnv()..load();
  final apiKey = env['GEOCODING_API_KEY'];
  if (apiKey == null) {
    throw Exception('"GEOCODING_API_KEY" environment variable is required');
  }

  while (true) {
    stdout.write(
        "Where would you like to check the weather for today? (city/address) [Enter 'q' to quit] ");
    final input = stdin.readLineSync();
    if (input == null) {
      print('Syntax: dart bin/main.dart <address>');
    } else if (input == 'q') {
      break;
    } else {
      final inputFormatted = input.replaceAll(' ', '+');
      final geoApi = GeocodingApiClient(apiKey: apiKey);
      final weatherApi = WeatherApiClient();
      try {
        final coordinates = await geoApi.getCoordinates(inputFormatted);
        final weather = await weatherApi.getWeatherData(coordinates);
        print('''

        Here is the weather for $input today:
''');
        weather.printWeatherData();
      } on ApiException catch (e) {
        print('\n${e.message}\n');
      } on SocketException catch (_) {
        print('\nCould not fetch data. Check your internet connection\n');
      } catch (e) {
        print('\n$e\n');
      }
    }
  }
  print(
      "\nWeather information provided by: Google\\OpenMeteo API's\nApp created by Nathan Hinckley\n");
}

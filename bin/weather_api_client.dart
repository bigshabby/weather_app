import 'dart:convert';
import 'package:http/http.dart' as http;
import 'geocoding_api_client.dart';
import 'weather.dart';

class WeatherApiClient {
  static const baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Weather> getWeatherData(Coordinates coordinates) async {
    final weatherUrl = Uri.parse(
        '$baseUrl?latitude=${coordinates.latitude}&longitude=${coordinates.longitude}&daily=weathercode,temperature_2m_max,temperature_2m_min'
        '&current_weather=true&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=auto');
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw ApiException(
          'Error getting weather data for requested address/city');
    }
    final weatherJSON = jsonDecode(weatherResponse.body) as Map;
    return Weather.fromJson(weatherJSON);
  }
}

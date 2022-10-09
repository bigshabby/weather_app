import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
}

class Coordinates {
  Coordinates({this.latitude = 0.0, this.longitude = 0.0});
  final latitude;
  final longitude;

  factory Coordinates.fromJson(Map json) => Coordinates(
        latitude: json['results'][0]['geometry']['location']['lat'],
        longitude: json['results'][0]['geometry']['location']['lng'],
      );

  @override
  String toString() {
    return 'Coordinates{latitude: $latitude, longitude: $longitude}';
  }
}

class GeocodingApiClient {
  GeocodingApiClient({required this.apiKey});
  final String apiKey;

  static const baseUrl = 'https://maps.googleapis.com/maps/api/geocode';

  Future<Coordinates> getCoordinates(String address) async {
    final locationUrl = Uri.parse('$baseUrl/json?address=$address&key=$apiKey');
    final locationResponse = await http.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw ApiException(
          'Error getting coordinates for requested address/city');
    }
    final locationJson = jsonDecode(locationResponse.body) as Map;
    if (locationJson['status'] == 'ZERO_RESULTS') {
      throw ApiException(
          'Invalid address/city. Please follow a standard format.');
    }
    return Coordinates.fromJson(locationJson);
  }
}

class Weather {
  Weather(
      {required this.temp,
      required this.windSpeed,
      required this.windDirection,
      required this.currentWeatherCode,
      required this.dailyWeatherCode,
      required this.tempMin,
      required this.tempMax});
  final double temp;
  final double windSpeed;
  final double windDirection;
  final double currentWeatherCode;
  final double tempMin;
  final double tempMax;
  final double dailyWeatherCode;

  factory Weather.fromJson(Map json) => Weather(
        temp: json['current_weather']['temperature'],
        windSpeed: json['current_weather']['windspeed'],
        windDirection: json['current_weather']['winddirection'],
        currentWeatherCode: json['current_weather']['weathercode'],
        tempMin: json['daily']['temperature_2m_min'][0],
        tempMax: json['daily']['temperature_2m_max'][0],
        dailyWeatherCode: json['daily']['weathercode'][0],
      );

  void printWeatherData() {
    print('''
        CURRENT WEATHER
        
        Temperature: $temp °F
        Wind Speed: $windSpeed mph
        Wind Direction: $windDirection° ${_convertDegreesToCardinalDirection(windDirection)}
        Weather Conditions: ${_getWeatherDescription(currentWeatherCode)}

        DAILY FORECAST
        
        Projected Low: $tempMin °F
        Projected High: $tempMax °F
        General Weather Conditions: ${_getWeatherDescription(dailyWeatherCode)}
        ''');
  }

  String _getWeatherDescription(double code) {
    int roundedCode = code.round();

    switch (roundedCode) {
      case (0):
        return 'Clear sky';
      case (1):
        return 'Mainly clear';
      case (2):
        return 'Partly cloudy';
      case (3):
        return 'Overcast';
      case (45):
        return 'Fog';
      case (48):
        return 'Depositing rime fog';
      case (51):
        return 'Light drizzle';
      case (53):
        return 'Moderate drizzle';
      case (55):
        return 'Dense drizzle';
      case (56):
        return 'Light freezing drizzle';
      case (57):
        return 'Dense freezing drizzle';
      case (61):
        return 'Slight rain';
      case (63):
        return 'Moderate rain';
      case (65):
        return 'Heavy rain';
      case (66):
        return 'Light freezing rain';
      case (67):
        return 'Heavy freezing rain';
      case (71):
        return 'Slight snow fall';
      case (73):
        return 'Moderate snow fall';
      case (75):
        return 'Heavy snow fall';
      case (77):
        return 'Snow grains';
      case (80):
        return 'Slight rain showers';
      case (81):
        return 'Moderate rain showers';
      case (82):
        return 'Violent rain showers';
      case (85):
        return 'Slight snow showers';
      case (86):
        return 'Heavy snow showers';
      case (95):
        return 'Slight/moderate thunderstorm';
      case (96):
        return 'Thunderstorm with slight hail';
      case (99):
        return 'Thunderstorm with heavy hail';
      default:
        return 'Current weather conditions: unavailable';
    }
  }

  String _convertDegreesToCardinalDirection(double degrees) {
    if (degrees > 337.5) return 'N';
    if (degrees > 292.5) return 'NW';
    if (degrees > 247.5) return 'W';
    if (degrees > 202.5) return 'SW';
    if (degrees > 157.5) return 'S';
    if (degrees > 122.5) return 'SE';
    if (degrees > 67.5) return 'E';
    if (degrees > 22.5) return 'NE';
    return 'N';
  }

  @override
  String toString() {
    return 'Weather{temp: $temp, windSpeed: $windSpeed, windDirection: $windDirection, currentWeatherCode: ' +
        '$currentWeatherCode, tempMin: $tempMin, tempMax: $tempMax, dailyWeatherCode: $dailyWeatherCode}';
  }
}

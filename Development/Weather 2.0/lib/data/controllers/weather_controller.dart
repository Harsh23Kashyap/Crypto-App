import 'package:flutter_clima/data/helper/network_helper.dart';
import 'package:flutter_clima/data/models/location.dart';
import 'package:flutter_clima/data/models/weather.dart';
import 'package:flutter_clima/utilities/constants.dart';

class WeatherController {
  NetworkHelper _network(String url) {
    return NetworkHelper(url);
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getWeatherByLocation() async {
    Location currentLocation = Location();
    await currentLocation.getCurrentLocation();

    var response = await _network(
      getWeatherByLocationUrl(
        currentLocation.latitude,
        currentLocation.longitude,
      ),
    ).getData();

    return Weather.fromJson(response);
  }

  Future<dynamic> getWeatherByCity(String cityName) async {
    var response = await _network(
      getWeatherByCityUrl(
        cityName,
      ),
    ).getData();

    return Weather.fromJson(response);
  }

  String getWeatherImage(int condition) {
    if (condition < 300) {
      // thunderstorm
      return 'assets/thunderstorm.png';
    } else if (condition < 400) {
      // drizzle
      return 'assets/drizzle.png';
    } else if (condition < 600) {
      // rain
      return 'assets/rain.png';
    } else if (condition < 700) {
      // snow
      return 'assets/snow.png';
    } else if (condition < 800) {
      // clear
      return 'assets/clear.png';
    } else if (condition < 804) {
      // cloudy
      return 'assets/cloudy.png';
    } else {
      return 'assets/stars.png';
    }
  }
}

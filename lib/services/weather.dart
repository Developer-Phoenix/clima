import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location l = Location();
    await l.getCurrentLocation();
    NetworkHelper networkhelper= NetworkHelper('$openWeatherMapURL?lat=${l.latitude}&lon=${l.longitude}&appid=$apikey&units=metric');
    var weatherData =  await networkhelper.getData();
    return weatherData;
  }
  Future<dynamic> getcity(String CityName) async{
    var url ='$openWeatherMapURL?q=$CityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData= await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}

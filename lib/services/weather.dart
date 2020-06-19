import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey='6de2a9703f3e3597bb13774ebd2fa0a4';
const weatherURL ='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String city)async{
    var url ='https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var cityData = await networkHelper.getData();
    return cityData;
    //coord.lon  coord.lat
  }

  Future<dynamic> getLocationWeather()async {
    Location obj=Location();
    await obj.getCurrentLocation();
//    latitude=(obj.latitude1);
//    longitude=(obj.longitude1);

    NetworkHelper networkHelper =NetworkHelper('$weatherURL?lat=${obj.latitude1}&lon=${obj.longitude1}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();//jsonDecode data

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
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
}

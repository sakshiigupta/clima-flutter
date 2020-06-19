import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.lW});
  final lW; //json decoded data

  @override
  _LocationScreenState createState() => _LocationScreenState();

}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();

  int temp;
  double tempt;
  int condition;
  String city;
  String icon;
  String message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.lW);
  }

  void updateUI(dynamic weatherData){

    setState(() {
      if (weatherData == null){
        temp = 0;
        city ='';
        icon = 'error';
        message =' error displaying the weather';
        return;
      }
      tempt= (jsonDecode(weatherData)['main']['temp']);
      temp= tempt.toInt();//main.temp
      city = jsonDecode(weatherData)['name']; //name
      condition = jsonDecode(weatherData)['weather'][0]['id']; //weather[0].id
      print('update UI');
      print(temp);
      print(city);
      print(condition);
      icon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temp);
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {

                        String city = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        print(city);
                        if(city!=null)
                          {
                            var cityData =  await WeatherModel().getCityWeather(city);
                            print(cityData);
                            //json data
                            updateUI(cityData);

                          }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "$message in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

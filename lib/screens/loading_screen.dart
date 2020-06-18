import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'package:geolocator/geolocator.dart';

const apiKey='6de2a9703f3e3597bb13774ebd2fa0a4';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState(){
    super.initState();
    getLocationData();
  }

  void getLocationData()async {
    Location obj=Location();
    await obj.getCurrentLocation();
    latitude=(obj.latitude1);
    longitude=(obj.longitude1);

    NetworkHelper networkHelper =NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));


  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.pink,
          size: 40.0,
          lineWidth: 5.0,

        ),
      )
    );
  }
}

//import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location{
  double latitude1;
  double longitude1;

  Future<void> getCurrentLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print('got location');
    latitude1=position.latitude;
    longitude1=position.longitude;
  }
}
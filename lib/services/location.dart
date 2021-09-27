import 'package:geolocator/geolocator.dart';

class Location {
  double latitude, longitude;
  Future<void> getCurrentLocation() async{
    // LocationPermission permission = await Geolocator.requestPermission();
    try {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude=pos.latitude;
      longitude=pos.longitude;
      // print ("latitude: $latitude  longitude: $longitude");
      print("location fetched");
    }
    catch(e){
      print(e);
    }
  }
}
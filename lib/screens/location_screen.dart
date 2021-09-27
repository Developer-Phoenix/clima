import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temprature;
  String cityname;
  String icon;
  String message;
  WeatherModel w = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData==null){
        temprature=0;
        icon='error';
        message= 'Unable to get Weather Data';
        cityname=' ';
        return;
      }
    double temp= weatherData['main']['temp'];
    temprature=temp.toInt();
    message = w.getMessage(temprature);
    var condition = weatherData['weather'][0]['id'];
    icon= w.getWeatherIcon(condition);
    cityname = weatherData['name'];
    });
    print("city: $cityname temp: $temprature");
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData= await w.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async{
                        var typedCity= await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        },));
                        if (typedCity != null){
                          var WeatherData= await w.getcity(typedCity);
                          updateUI(WeatherData);
                        }
                      },
                      child: Icon(
                        Icons.search_rounded,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: SafeArea(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temprature°',
                          style: kTempTextStyle,
                        ),
                        SafeArea(
                          child: Text(
                            icon,
                            style: kConditionTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message in $cityname!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// var temprature= weatherData['main']['temp']-273;
// var weatherDescrpiton = weatherData['weather'][0]['id'];
// var cityName = weatherData['name'];

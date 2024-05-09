import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_models.dart';
import 'package:weatherapp/services/weather_services.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('aa5895c910cbf3f839df8848d5300a5e');
  Weather? _weather;


  _fetchWeather()async{
    String cityName =await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainConditaion){
    if (mainConditaion == null) {
        return 'assets/sunny.json';
    }

    switch (mainConditaion.toLowerCase()) {
      case 'clouds':
      case'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
       return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';

    }
  }


  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50),
              child: Icon(Icons.location_on_outlined),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weather?.cityName??"Loading city...",style: TextStyle(color: Colors.black,fontSize: 20),),
                ],
              ),
              SizedBox(height: 200,),
              Lottie.asset(getWeatherAnimation(_weather?.mainConditions)),
              Text('${_weather?.temparature.round()}*C'),
              Text(_weather?.mainConditions??"")
          ],
        ),
      ),  
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherStatePage();
}

class _WeatherStatePage extends State<WeatherPage> {

  final _weatherService = WeatherService('b05da7e010dc0a24c70018a95204245a');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch(e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'Flutter Assets/Sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'Flutter Assets/Cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'Flutter Assets/Partle Cloud.json';
      default: 
        return 'Flutter Assets/Sunny.json';
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(_weather?.cityName ?? "loading city"),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text('${_weather?.temperature.round()}C' ),

            Text(_weather?.mainCondition ?? ""),

          ],
        ),
      ),
    );
  }
}



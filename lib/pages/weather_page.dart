import 'package:flutter/material.dart';
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
            Text('${_weather?.temperature.round()}C' )
          ],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: '6708f4e44d161b6f51e1866d588a406c');
  WeatherModel? _weather;


  fetchWeather() async {
   
      String city = await _weatherService.getCurrentLocation();
      print(city);
      final weather = await _weatherService.getWeather(city);
      print(weather);
      setState(() {
        _weather = weather;
      });
      print(_weather?.city);
   
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: _weather == null
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                        children: [
                          Text(_weather?.city ?? 'Loading...'),
                          Text(_weather?.desc ?? 'Loading...'),
                          Text(_weather?.temp.toString() ?? 'Loading...'),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: '6708f4e44d161b6f51e1866d588a406c');
  WeatherModel? _weather;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final city = await _weatherService.getCurrentLocation();
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
                  children: [
                    ElevatedButton(onPressed: fetchWeather, child: Text('Fetch Weather')),
                    Text(_weather!.city),
                    Text(_weather!.desc),
                  ],
                ),
        ),
      ),
    );
  }
}

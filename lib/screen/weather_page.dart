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
  String _errorMessage = '';

  fetchWeather() async {
    try {
      final city = await _weatherService.getCurrentLocation();
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = 'Error fetching weather data';
      });
    }
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
          body: _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _weather == null
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

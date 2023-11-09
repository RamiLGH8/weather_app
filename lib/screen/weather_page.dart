import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:lottie/lottie.dart';

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

    setState(() {
      _weather = weather;
    });
    print(weather.formattedTime(_weather!.time));
    print(_weather?.city);
  }

  String getLottieAsset(
      String desc, String time, String sunRise, String sunSet) {
    print(desc);
    print(time);
    print(sunRise);
    print(sunSet);
    if (desc.toLowerCase().contains('clouds')) {
      return 'assets/cloudy.json';
    }
    if (desc.toLowerCase().contains('rain')) {
      return 'assets/rainy.json';
    }
    if (desc.toLowerCase().contains('thunder')) {
      return 'assets/thunder.json';
    }
    if (desc.toLowerCase().contains('snow')) {
      return 'assets/snow.json';
    }
    // if (desc.toLowerCase().contains('clear') &&
    //     time.compareTo(sunRise) == 1 &&
    //     time.compareTo(sunSet) == -1) {
    //   return 'assets/sunny.json';
    // }
    if (desc.toLowerCase().contains('clear') && time.compareTo(sunRise) == -1) {
      return 'assets/night_clear.json';
    }

    switch (desc.toLowerCase()) {
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'drizzle':
        return 'assets/rainy.json';
      default:
        if (time.compareTo(sunRise) == 1 && time.compareTo(sunSet) == -1)
          return 'assets/sunny.json';
        else
          return 'assets/night_clear.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: _weather == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                  width: width,
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_weather!.city),
                        Text(_weather!.temp.toInt().toString() + '°C'),
                        Lottie.asset(getLottieAsset(
                            _weather!.desc,
                            _weather!.formattedTime(_weather!.time),
                            _weather!.formattedTime(_weather!.sunRise),
                            _weather!.formattedTime(_weather!.sunSet))),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

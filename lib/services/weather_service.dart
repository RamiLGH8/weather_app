import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static final BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final apiKey;

  WeatherService({required this.apiKey});

  Future<WeatherModel> getWeather(String city) async {
    String ct = city;

    final response = await http.get(Uri.parse('$BASE_URL?q=$ct&appid=$apiKey&units=metric'));
    print(response.toString());

    return WeatherModel.fromMap(jsonDecode(response.body));
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Permission denied';
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String city = placemarks[0].locality!;
    return city;
  }
}

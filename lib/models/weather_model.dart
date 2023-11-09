class WeatherModel {
  final double temp;
  final String city;
  final String desc;

  WeatherModel({required this.temp, required this.city, required this.desc});

  WeatherModel.fromMap(Map<String, dynamic> json)
      : city = json['name'],
        temp = json['main']['temp'],
        desc = json['weather'][0]['description'];
}

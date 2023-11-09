class WeatherModel {
  final double temp;
  final String city;
  final String desc;
  final DateTime time;
  final DateTime sunRise; 
  final DateTime sunSet; 

  WeatherModel(
      {required this.temp,
      required this.city,
      required this.desc,
      required this.time,
      required this.sunRise,
      required this.sunSet
      });

  WeatherModel.fromMap(Map<String, dynamic> json)
      : city = json['name'],
        temp = json['main']['temp'],
        desc = json['weather'][0]['description'],
        time = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        sunRise = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunSet = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000);

  String formattedTime(DateTime time) {
    return '${time.hour}:${time.minute}';
  }
}

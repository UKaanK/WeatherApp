class Weather{
    final String cityName;
    final double temparature;
    final String mainConditions;

    Weather({required this.cityName,required this.temparature,required this.mainConditions });
    factory Weather.fromJson(Map<String,dynamic> json) {
      return Weather(cityName: json['name'], temparature: json['main']['temp'].toDouble(), mainConditions: json['weather'][0]['main']);
    }
}
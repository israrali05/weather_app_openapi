import 'package:weather_app_openapi/model/weather_data_current.dart';
import 'package:weather_app_openapi/model/weather_data_hourly.dart';
import 'package:weather_app_openapi/model/weathr_data_daily.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  WeatherData([this.current, this.hourly, this.daily]);

  // function to fectch data
  WeatherDataCurrent getWeatherCurrent() => current!;
  WeatherDataHourly getWeatherhourly() => hourly!;
  WeatherDataDaily getWeatherDataDaily() => daily!;
}

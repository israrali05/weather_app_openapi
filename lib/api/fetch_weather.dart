import 'dart:convert';

import 'package:weather_app_openapi/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_openapi/model/weather_data_current.dart';
import 'package:weather_app_openapi/consts/consts.dart';
import 'package:weather_app_openapi/model/weather_data_hourly.dart';
import 'package:weather_app_openapi/model/weathr_data_daily.dart';

//  processing the Data from Response to json
class FetchWeatherAPI {
  WeatherData? weatherData;
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
    WeatherDataHourly.fromJson(jsonString),
    WeatherDataDaily.fromJson(jsonString));
    return weatherData!;
  }
}


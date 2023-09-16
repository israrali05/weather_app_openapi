import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_openapi/api/fetch_weather.dart';
import 'package:weather_app_openapi/model/weather_data.dart';

class GLobalController extends GetxController {
  //  Create Various Variables
  final RxBool _isloading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final weatherData = WeatherData().obs;
  final RxInt _currentIndex = 0.obs;

//  get Weather data
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  //  instance for Them to be Called

  RxBool checkLoading() => _isloading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  RxInt getIndex() => _currentIndex;

  @override
  void onInit() {
    if (_isloading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

// check Location Permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location services are denied forever.');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    //  Getting the Current Position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //  update our latitude and longitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      return FetchWeatherAPI()
          .processData(_lattitude.value, _longitude.value)
          .then((value) {
        weatherData.value = value;
        _isloading.value = false;
      });
    });
  }
}

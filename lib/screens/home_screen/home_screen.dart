import 'package:get/get.dart';
import 'package:weather_app_openapi/consts/consts.dart';
import 'package:weather_app_openapi/controller/global_controller.dart';
import 'package:weather_app_openapi/screens/home_screen/components/current_weather_widget.dart';
import 'package:weather_app_openapi/screens/home_screen/components/dialy_weather_widget.dart';
import 'package:weather_app_openapi/screens/home_screen/components/header_widget.dart';
import 'package:weather_app_openapi/screens/home_screen/components/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GLobalController globalController =
      Get.put(GLobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),

                    // for the current temperature 
                    CurrentWeatherWidget(weatherDataCurrent: globalController.getWeatherData().getWeatherCurrent()),
                    HourlyDataWidget(weatherDataHourly: globalController.getWeatherData().getWeatherhourly()),
                    DialyWeatherForecast(weatherDataDaily: globalController.getWeatherData().getWeatherDataDaily(),)
                  ],
                ))),
    );
  } 
}
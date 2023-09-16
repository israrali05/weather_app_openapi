import 'package:intl/intl.dart';
import 'package:weather_app_openapi/consts/consts.dart';
import 'package:weather_app_openapi/model/weathr_data_daily.dart';

class DialyWeatherForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DialyWeatherForecast({super.key, required this.weatherDataDaily});

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: dividerLine, borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            "Next Days",
            style: TextStyle(color: textColorBlack, fontSize: 17),
          ),
        ),
        dialyList(),
      ]),
    );
  }

  Widget dialyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: weatherDataDaily.daily.length > 7
              ? 7
              : weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 80,
                        child: Text(getDay(weatherDataDaily.daily[index].dt),
                        style: const TextStyle(
                          color: textColorBlack,
                          fontSize: 14
                        ),),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                        ),
                          Text("${weatherDataDaily.daily[index].temp!.max}°/${weatherDataDaily.daily[index].temp!.max}°")

                      ]),
                ),
                Container(
                  height: 3,
                  color: dividerLine,
                )
              ],
            );
          }),
    );
  }
}

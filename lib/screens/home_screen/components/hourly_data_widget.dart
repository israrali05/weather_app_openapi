import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:weather_app_openapi/consts/consts.dart';
import 'package:weather_app_openapi/controller/global_controller.dart';
import 'package:weather_app_openapi/model/weather_data_hourly.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

//  card Index
  RxInt cardIndex = GLobalController().getIndex();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: const Text(
            'Today',
            style: TextStyle(fontSize: 16),
          ),
        ),
        hourlyListWidget(),
      ],
    );
  }

  Widget hourlyListWidget() {
    return Container(
    
        height: 150,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherDataHourly.hourly.length > 12
                ? 12
                : weatherDataHourly.hourly.length,
            itemBuilder: (context, index) {
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    cardIndex.value = index;
                  },
                  child: Container(
                    width: 60,
      margin:  const EdgeInsets.only(left: 20, right: 5),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0.5, 0),
                              blurRadius: 30,
                              spreadRadius: 1,
                              color: dividerLine.withAlpha(150))
                        ],
                        gradient: cardIndex.value == index
                            ? const LinearGradient(colors: [
                                firstGradientColor,
                                secondGradientColor
                              ])
                            : null),
                    child: HourlyDetails(
                      index: index,
                      curentIndex: cardIndex.value,
                      temp: weatherDataHourly.hourly[index].temp!,
                      timeStamp: weatherDataHourly.hourly[index].dt!,
                      weatherIcon:
                          weatherDataHourly.hourly[index].weather![0].icon!,
                    ),
                  ),
                ),
              );
            }));
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  int index;
  int curentIndex;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  HourlyDetails(
      {super.key,
      required this.index,
      required this.curentIndex,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp), style: TextStyle(
            color: curentIndex == index? Colors.white 
            : textColorBlack
          ),),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°", style: TextStyle(
            color: curentIndex == index? Colors.white 
            : textColorBlack
          )),
        )
      ],
    );
  }
}

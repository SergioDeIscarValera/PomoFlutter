import 'package:PomoFlutter/content/home/models/daily_data.dart';

class DailyDataUtils {
  static double getMaxFromList(List<DailyData> dailyData) {
    double maxBruto = dailyData.isNotEmpty
        ? dailyData
            .map((e) => e.categoryTimes.values
                .map((e) => e.workingTime > e.breakingTime
                    ? e.workingTime.toDouble()
                    : e.breakingTime.toDouble())
                .reduce((value, element) => value + element))
            .reduce((value, element) => value > element ? value : element)
            .toDouble()
        : 1;
    // Divide entre 60 para pasar de segundos a minutos y redondear a la decena superior
    return ((maxBruto ~/ 60) / 10).ceil() * 10;
  }
}

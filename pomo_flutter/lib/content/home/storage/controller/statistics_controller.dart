import 'package:PomoFlutter/content/auth/storage/controller/auth_controller.dart';
import 'package:PomoFlutter/content/home/models/daily_data.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/models/timer_status.dart';
import 'package:PomoFlutter/content/home/services/daily_data_repository.dart';
import 'package:PomoFlutter/content/home/services/interface_daily_data_repository.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  final RxMap<DateTime, DailyData> _dailyData = RxMap<DateTime, DailyData>({});
  final Rx<DailyData?> todayDailyData = Rx<DailyData?>(null);
  final RxList<DailyData> monthDailyData = RxList<DailyData>([]);

  final AuthController authController = Get.find();
  final IDailyDataRepository _dailyDataRepository = DailyDataRepository();

  @override
  void onInit() {
    _dailyDataRepository.addListener(
      idc: authController.firebaseUser!.email!,
      listener: (dailyDatas) {
        _dailyData.clear();
        for (var dailyData in dailyDatas) {
          _dailyData[dailyData.date] = dailyData;
        }
      },
    );

    _dailyData.listen((dailyData) {
      monthDailyData.clear();
      var today = DateTime.now();
      var lastDayOfCurrentMonth = today.subtract(const Duration(days: 30)).day;

      for (var dailyData in _dailyData.values) {
        if (dailyData.date.day == today.day &&
            dailyData.date.month == today.month &&
            dailyData.date.year == today.year) {
          todayDailyData.value = dailyData;
        }
        if (dailyData.date.isAfter(today.subtract(const Duration(days: 30))) &&
            dailyData.date.isBefore(today)) {
          monthDailyData.add(dailyData);
        }
      }
      // Rellenar los dias que no hay datos
      for (int i = 1; i <= lastDayOfCurrentMonth; i++) {
        var day = DateTime(today.year, today.month, i);
        if (!_dailyData.containsKey(day)) {
          monthDailyData.add(DailyData.empty(date: day));
        }
      }
      // Ordenar los datos
      monthDailyData.sort((a, b) => a.date.compareTo(b.date));
    });

    super.onInit();
  }

  void addTime(
      TimerStatus status, TaskCategory category, DateTime date, int time) {
    // Solo importa el dia, no la hora
    date = DateTime(date.year, date.month, date.day);
    switch (status) {
      case TimerStatus.BREAK:
        _addBreackTime(category, date, time);
        break;
      case TimerStatus.WORKING:
        _addWorkingTime(category, date, time);
        break;
    }
    _saveDailyData(_dailyData[date]!);
  }

  void _addBreackTime(TaskCategory category, DateTime date, int time) {
    if (!_dailyData.containsKey(date)) {
      _dailyData[date] = DailyData(date: date, categoryTimes: {
        category: CategoryTime(
          category: category,
          workingTime: 0,
          breakingTime: time,
        )
      });
    } else {
      _dailyData[date]!.categoryTimes[category]!.breakingTime += time;
    }
  }

  void _addWorkingTime(TaskCategory category, DateTime date, int time) {
    if (!_dailyData.containsKey(date)) {
      _dailyData[date] = DailyData(date: date, categoryTimes: {
        category: CategoryTime(
          category: category,
          workingTime: time,
          breakingTime: 0,
        )
      });
    } else {
      //_dailyData[date]!.categoryTimes[category]!.workingTime += time;
      if (!_dailyData[date]!.categoryTimes.containsKey(category)) {
        _dailyData[date]!.categoryTimes[category] = CategoryTime(
          category: category,
          workingTime: time,
          breakingTime: 0,
        );
      } else {
        _dailyData[date]!.categoryTimes[category]!.workingTime += time;
      }
    }
  }

  void _saveDailyData(DailyData dailyData) {
    _dailyDataRepository.save(
      idc: authController.firebaseUser!.email!,
      entity: dailyData,
    );
  }
}
